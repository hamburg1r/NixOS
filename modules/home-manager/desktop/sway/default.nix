{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        pkgs,
        lib,
        ...
      }: let
        dEnv = config.desktop;
        kb = dEnv.keybinds;

        # sway shares the i3 kconfig syntax.
        normMod = m:
          if m == "Control" || m == "Ctrl"
          then "Ctrl"
          else if m == "Alt"
          then "Mod1"
          else if m == "super" || m == "Super"
          then "Mod4"
          else m;
        normKey = k:
          if k == "left"
          then "Left"
          else if k == "right"
          then "Right"
          else if k == "up"
          then "Up"
          else if k == "down"
          then "Down"
          else if k == "return"
          then "Return"
          else k;

        # [ [extraMods...] [key] ] -> "Mod+Extra+Key" (with the shared base modifier)
        fmtBase = mod: bind: let
          mods = lib.map normMod (lib.head bind);
          keys = lib.map normKey (lib.last bind);
        in
          lib.concatStringsSep "+" ([mod] ++ mods ++ keys);
        fmt = fmtBase (normMod dEnv.modifier);
        fmtNoMod = fmtBase "";

        execCmd = cmd: "exec ${lib.concatStringsSep " " cmd}";

        # Focus/move binds for every key listed for a direction (vim keys + arrows)
        movementBinds = let
          genDir = dir: let
            keys = lib.getAttr dir kb.movement;
          in
            lib.foldl' (acc: key:
              acc
              // {
                "${fmt [[] [key]]}" = "focus ${dir}";
                "${fmt [["Shift"] [key]]}" = "move ${dir}";
              }) {}
            keys;
        in
          lib.foldl' (acc: dir: acc // genDir dir) {}
          ["left" "down" "up" "right"];

        # Screenshots from the shared vocabulary (grim+slurp+swappy pipeline)
        screenshotBinds = {
          "${fmt kb.screenshot}" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.swappy}/bin/swappy -f -";
          "${fmt kb.fullscreen-screenshot}" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f -";
          "${fmt kb.window-screenshot}" = "exec ${pkgs.grim}/bin/grim -g \"$(swaymsg -t get_tree | ${pkgs.jq}/bin/jq '.. | objects | select(.focused == true) | .rect | \"\\(.x),\\(.y) \\(.width)x\\(.height)\"' -r)\" - | ${pkgs.swappy}/bin/swappy -f -";
        };

        # Multimedia/screen keys from the shared vocabulary -> config.desktop.actions
        mediaBinds = {
          "${fmtNoMod kb.no-mod.speaker-volume-up}" = execCmd dEnv.actions.volume-up;
          "${fmtNoMod kb.no-mod.speaker-volume-down}" = execCmd dEnv.actions.volume-down;
          "${fmtNoMod kb.no-mod.speaker-mute}" = execCmd dEnv.actions.volume-mute;
          "${fmtNoMod kb.no-mod.mic-volume-up}" = execCmd dEnv.actions.mic-volume-up;
          "${fmtNoMod kb.no-mod.mic-volume-down}" = execCmd dEnv.actions.mic-volume-down;
          "${fmtNoMod kb.no-mod.mic-mute}" = execCmd dEnv.actions.mic-mute;
          "${fmtNoMod kb.no-mod.mpiris-play-pause}" = execCmd dEnv.actions.mpiris-play-pause;
          "${fmtNoMod kb.no-mod.mpiris-stop}" = execCmd dEnv.actions.mpiris-stop;
          "${fmtNoMod kb.no-mod.mpiris-previous}" = execCmd dEnv.actions.mpiris-previous;
          "${fmtNoMod kb.no-mod.mpiris-next}" = execCmd dEnv.actions.mpiris-next;
          "${fmtNoMod kb.no-mod.brightness-up}" = execCmd dEnv.actions.brightness-up;
          "${fmtNoMod kb.no-mod.brightness-down}" = execCmd dEnv.actions.brightness-down;
        };
      in {
        wayland.windowManager.sway = {
          config = {
            menu = lib.concatStringsSep " " dEnv.programs.app-launcher;
            terminal = lib.concatStringsSep " " dEnv.programs.terminal;
            assigns = {
              "2" = [{app_id = "^firefox$";}];
              "4" = [{app_id = "^discord$";}];
            };
            keybindings =
              {
                # --- shared desktop.keybinds (desktop/keybinds.nix) ---
                "${fmt kb.terminal}" = "exec ${lib.concatStringsSep " " dEnv.programs.terminal}";
                "${fmt kb.app-launcher}" = execCmd dEnv.programs.app-launcher;
                "${fmt kb.close-window}" = "kill";
                "${fmt kb.quit}" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
                "${fmt kb.fullscreen}" = "fullscreen toggle";
                "${fmt kb.toggle-floating}" = "floating toggle";
              }
              // movementBinds
              // screenshotBinds
              // mediaBinds
              // {
                # --- existing sway-specific binds (kept) ---
                "${fmt [["Shift"] ["c"]]}" = "kill";
                "${fmt [[] ["a"]]}" = "focus parent";
                "${fmt [[] ["b"]]}" = "splith";
                "${fmt [[] ["v"]]}" = "splitv";
                "${fmt [[] ["s"]]}" = "layout stacking";
                "${fmt [[] ["w"]]}" = "layout tabbed";
                "${fmt [[] ["e"]]}" = "layout toggle split";
                "${fmt [[] ["space"]]}" = "focus mode_toggle";
                # Mod+r is the shared app-launcher; keep resize mode on a free key
                "${fmt [["Control"] ["r"]]}" = "mode resize";
                "${fmt [[] ["minus"]]}" = "scratchpad show";
                "${fmt [["Shift"] ["minus"]]}" = "move scratchpad";

                # Workspaces (kept from previous config)
              }
              // lib.listToAttrs (
                lib.concatMap (ws: [
                  {
                    name = "${fmt [[] [(toString ws)]]}";
                    value = "workspace number ${toString ws}";
                  }
                  {
                    name = "${fmt [["Shift"] [(toString ws)]]}";
                    value = "move container to workspace number ${toString ws}";
                  }
                ])
                (lib.genList (x: x + 1) 9)
              )
              // {
                # Legacy screenshot keys (kept)
                "Print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f -";
                "Shift+Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.swappy}/bin/swappy -f -";
              };
            floating.criteria = [
              {
                title = "^Picture-in-Picture$";
                app_id = "^firefox$";
              }
              {
                title = "[Ee]xtension.*[Tt]ree\\s[Ss]tyle\\s[Tt]ab.*[Cc]lose\\s[Tt]abs";
                app_id = "^firefox$";
              }
            ];
            window.commands = [
              {
                criteria = {
                  app_id = "^pavucontrol$";
                };
                command = "move window to scratchpad";
              }
              {
                criteria = {
                  title = "^Open File$";
                  app_id = "^firefox$";
                };
                command = "sticky enable";
              }
              {
                criteria = {
                  title = "^Picture-in-Picture$";
                  app_id = "^firefox$";
                };
                command = "sticky enable";
              }
            ];
            gaps = {
              smartGaps = true;
              inner = 5;
              # outer = 5;
            };
            modifier = "Mod4";
            input = {
              "type:touchpad" = {
                tap = "enabled";
                drag = "enabled";
                drag_lock = "enabled";
                middle_emulation = "enabled";
              };
            };
            startup = [
              {command = "discord";}
              {command = "pwvucontrol";}
              {command = "eww daemon && eww open topbar";}
              {command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.cliphist}/bin/cliphist store";}
              {command = "${pkgs.wl-clipboard}/bin/wl-paste -t image --watch ${pkgs.cliphist}/bin/cliphist store";}
              # { command = ""; }
              {command = "$(home-manager generations | head -1 | awk '{print $7 \"/specialisation/wayland\"}')";}
            ];
            output = {
              eDP-1 = {
                bg = lib.toString config.wallpaper.desktop.output;
              };
            };
            workspaceAutoBackAndForth = true;
          };
          extraConfig = ''
            corner_radius 10
            # default_dim_inactive 0.5
          '';
        };
      }
    )
  ];
}
