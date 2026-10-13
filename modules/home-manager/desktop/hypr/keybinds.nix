{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        pkgs,
        lib,
        ...
      }: let
        cfg = config.desktop; # This comes from the main keybinds.nix options
        kb = cfg.keybinds;
        mod = cfg.modifier;

        listToString = list: lib.strings.concatStringsSep " " list;

        terminalExe = listToString cfg.programs.terminal;
        launcherExe = listToString cfg.programs.app-launcher;

        # Hyprland modifier names differ from the vocabulary's; normalise them.
        normMod = m:
          if m == "Control" || m == "Ctrl"
          then "CTRL"
          else if m == "Alt"
          then "ALT"
          else if m == "Shift"
          then "SHIFT"
          else if m == "super" || m == "Super"
          then "SUPER"
          else lib.strings.toUpper m;

        # [ [extraMods...] [key] ] + a base modifier list -> "SUPER SHIFT, X"
        # Hyprland wants the base modifier space-joined with the extra modifiers
        # before the comma, and the key (case preserved, e.g. XF86AudioMute) after it.
        mkHotkey = mods: keybindList: let
          modifiers = lib.map normMod (lib.head keybindList);
          key = lib.head (lib.last keybindList);
        in
          "${lib.concatStringsSep " " (mods ++ modifiers)}, ${key}";

        # Most binds carry the shared base modifier...
        fmt = mkHotkey [(normMod mod)];
        # ...media keys carry only their own modifiers, no base Mod.
        fmtNoMod = mkHotkey [];
      in {
        config = {
          wayland.windowManager.hyprland.settings = {
            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            bind =
              [
                # --- shared desktop.keybinds (desktop/keybinds.nix) ---
                "${fmt kb.terminal}, exec, ${terminalExe}"
                "${fmt kb.app-launcher}, exec, ${launcherExe}"
                "${fmt kb.close-window}, killactive, "
                "${fmt kb.quit}, exit, "
                "${fmt kb.fullscreen}, fullscreen, 0"
                "${fmt kb.maximize}, fullscreen, 1"
                "${fmt kb.toggle-windowed-fullscreen}, fullscreenstate, -1 2,"
                "${fmt kb.toggle-floating}, togglefloating,"
                "${fmt kb.toggle-tabbed-window}, togglegroup,"

                # --- media keys from the shared vocabulary ---
                "${fmtNoMod kb.no-mod.speaker-mute}, exec, ${listToString cfg.actions.volume-mute}"
                "${fmtNoMod kb.no-mod.mic-mute}, exec, ${listToString cfg.actions.mic-mute}"
                "${fmtNoMod kb.no-mod.mpiris-play-pause}, exec, ${listToString cfg.actions.mpiris-play-pause}"
                "${fmtNoMod kb.no-mod.mpiris-stop}, exec, ${listToString cfg.actions.mpiris-stop}"
                "${fmtNoMod kb.no-mod.mpiris-previous}, exec, ${listToString cfg.actions.mpiris-previous}"
                "${fmtNoMod kb.no-mod.mpiris-next}, exec, ${listToString cfg.actions.mpiris-next}"
                "${fmtNoMod kb.no-mod.brightness-up}, exec, ${listToString cfg.actions.brightness-up}"
                "${fmtNoMod kb.no-mod.brightness-down}, exec, ${listToString cfg.actions.brightness-down}"

                # Screenshot utilities (shared keys, hyprland-specific wayshot pipeline)
                "${fmt kb.screenshot}, exec, ${pkgs.wayshot}/bin/wayshot --slurp \"$(${pkgs.slurp}/bin/slurp)\" --stdout | ${pkgs.swappy}/bin/swappy -f -"
                "${fmt kb.fullscreen-screenshot}, exec, ${pkgs.wayshot}/bin/wayshot --stdout | ${pkgs.swappy}/bin/swappy -f -"
                "${fmt kb.window-screenshot}, exec, ${pkgs.wayshot}/bin/wayshot --slurp \"$(hyprctl activewindow -j | ${pkgs.jq}/bin/jq '.at as $a| .size as $s| \"($a[0]),\($a[1]) \($s[0])x\($s[1])\"' -r)\" --stdout | ${pkgs.swappy}/bin/swappy -f -"

                # --- existing hyprland-specific binds (kept) ---
                "${mod}, e, exec, ${terminalExe} lf"
                "${mod} ALT, r, exec, hyprctl reload"
                "${mod} SHIFT, r, exec, ags quit; ags"

                "${mod}, space, cyclenext, floating"
                "${mod} ALT, space, cyclenext, tiled"

                "${mod} SHIFT, minus, movetoworkspace, special"
                "${mod}, minus, togglespecialworkspace,"
                "${mod} ALT, minus, submap, specialWorkspaces"

                "${mod}, u, focusurgentorlast,"

                # Scroll through existing workspaces with mainMod + scroll
                "${mod}, mouse_down, workspace, e+1"
                "${mod}, mouse_up, workspace, e-1"

                "${mod}, TAB, changegroupactive,"
                "${mod} SHIFT, TAB, changegroupactive, b"

                # Global keybinds
                "CTRL ALT, m, sendshortcut, CTRL SHIFT, m, title:(.*)(- Discord)$"
                "CTRL ALT, n, sendshortcut, CTRL SHIFT, d, title:(.*)(- Discord)$"
              ]
              # Focus/move binds for every key listed for a direction (vim keys + arrows)
              ++ (lib.concatMap (dir: let
                  keys = lib.getAttr dir kb.movement;
                  hyprDir = {
                    left = "l";
                    right = "r";
                    up = "u";
                    down = "d";
                  }.${
                    dir
                  };
                in
                  lib.concatMap (key: [
                    "${fmt [[] [key]]}, movefocus, ${hyprDir}"
                    "${fmt [["Shift"] [key]]}, movewindoworgroup, ${hyprDir}"
                  ])
                  keys)
                ["left" "right" "up" "down"])
              ++ (
                # 	builtins.concatLists [
                # 		( builtins.concatMap (
                # 			key: if config.wm.hyprland.layout == "hy3" then [
                # 				"${mod}, ${key}, hy3:movefocus, l"
                # 				"${mod} SHIFT, ${key}, hy3:movewindow, l"
                # 			] else [
                # 				"${mod}, ${key}, movefocus, l"
                # 			]
                # 		) cfg.keybinds.movement.left )
                # 		( builtins.concatMap (
                # 			key: if config.wm.hyprland.layout == "hy3" then [
                # 				"${mod}, ${key}, hy3:movefocus, r"
                # 				"${mod} SHIFT, ${key}, hy3:movewindow, r"
                # 			] else [
                # 				"${mod}, ${key}, movefocus, r"
                # 			]
                # 		) cfg.keybinds.movement.right )
                # 		( builtins.concatMap (
                # 			key: if config.wm.hyprland.layout == "hy3" then [
                # 				"${mod}, ${key}, hy3:movefocus, u"
                # 				"${mod} SHIFT, ${key}, hy3:movewindow, u"
                # 			] else [
                # 				"${mod}, ${key}, movefocus, u"
                # 			]
                # 		) cfg.keybinds.movement.up )
                # 		( builtins.concatMap (
                # 			key: if config.wm.hyprland.layout == "hy3" then [
                # 				"${mod}, ${key}, hy3:movefocus, d"
                # 				"${mod} SHIFT, ${key}, hy3:movewindow, d"
                # 			] else [
                # 				"${mod}, ${key}, movefocus, d"
                # 			]
                # 		) cfg.keybinds.movement.down )
                # 	]
                # ) ++ (
                # 	if config.wm.hyprland.layout == "hy3" then [
                # 		"${mod}, v, hy3:makegroup, v, force_empheral"
                # 		"${mod}, b, hy3:makegroup, h, force_empheral"
                # 		"${mod}, t, hy3:makegroup, tab, force_empheral"
                # 		"${mod} CTRL, k, hy3:changefocus, raise"
                # 		"${mod} CTRL, j, hy3:changefocus, lower"
                # 	] else []
                if cfg.hyprland.layoutName == "dwindle"
                then [
                  "${mod}, p, pseudo,"
                  "${mod} SHIFT, t, togglesplit,"
                ]
                else []
              )
              ++ (
                lib.concatLists (
                  lib.genList (
                    x: let
                      ws = let
                        c = (x + 1) / 10;
                      in
                        lib.toString (x + 1 - (c * 10));
                    in [
                      "${mod}, ${ws}, workspace, ${lib.toString (x + 1)}"
                      "${mod} SHIFT, ${ws}, movetoworkspace, ${lib.toString (x + 1)}"
                      # (
                      # 	if config.wm.hyprland.layout == "hy3" then
                      # 		"${mod} SHIFT, ${ws}, hy3:movetoworkspace, ${builtins.toString (x + 1)}"
                      # 	else "${mod} SHIFT, ${ws}, hyprctl dispatch movetoworkspace ${builtins.toString (x + 1)}"
                      # )
                    ]
                  )
                  10
                )
              );

            binde = [
              # Audio and media controls
              "${fmtNoMod kb.no-mod.speaker-volume-up}, exec, ${listToString cfg.actions.volume-up}"
              "${fmtNoMod kb.no-mod.speaker-volume-down}, exec, ${listToString cfg.actions.volume-down}"

              ## input
              "${fmtNoMod kb.no-mod.mic-volume-up}, exec, ${listToString cfg.actions.mic-volume-up}"
              "${fmtNoMod kb.no-mod.mic-volume-down}, exec, ${listToString cfg.actions.mic-volume-down}"
            ];

            bindm = [
              # Move/resize windows with mainMod + LMB/RMB and dragging
              "${mod}, mouse:272, movewindow"
              "${mod}, mouse:273, resizewindow 1"
              "${mod} SHIFT, mouse:273, resizewindow"
            ];
          };
        };
      }
    )
  ];
}
