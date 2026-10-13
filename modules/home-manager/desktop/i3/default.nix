{config, ...}: {
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

        # i3 keys are case-sensitive for letters but use X11 names for modifiers/arrows.
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
        # media keys carry only their own modifiers, no base Mod
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
          "${fmt kb.window-screenshot}" = "exec ${pkgs.grim}/bin/grim -g \"$(i3-msg -t get_tree | ${pkgs.jq}/bin/jq '.. | objects | select(.focused == true) | .rect | \"\\(.x),\\(.y) \\(.width)x\\(.height)\"' -r)\" - | ${pkgs.swappy}/bin/swappy -f -";
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
        xsession.windowManager.i3 = {
          enable = false;
          config = {
            assigns = {
              "4" = [{class = "^discord";}];
            };
            keybindings =
              {
                # --- shared desktop.keybinds (desktop/keybinds.nix) ---
                "${fmt kb.terminal}" = "exec ${lib.concatStringsSep " " dEnv.programs.terminal}";
                "${fmt kb.app-launcher}" = execCmd dEnv.programs.app-launcher;
                "${fmt kb.close-window}" = "kill";
                "${fmt kb.quit}" = "exec i3-nag -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your Desktop session.' -b 'Yes, exit i3' 'i3-msg exit'";
                "${fmt kb.fullscreen}" = "fullscreen toggle";
                "${fmt kb.toggle-floating}" = "floating toggle";
              }
              // movementBinds
              // screenshotBinds
              // mediaBinds
              // {
                # --- existing i3-specific binds (kept) ---
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
            modifier = "Mod4";
            terminal = lib.concatStringsSep " " dEnv.programs.terminal;
            startup = [
              {command = "discord";}
            ];
            workspaceAutoBackAndForth = true;
          };
        };
      }
    )
  ];
}
