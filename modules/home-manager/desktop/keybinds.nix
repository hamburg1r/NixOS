{
	config,
	lib,
	pkgs,
	...
}: {
	options = with lib; {
		desktop = {
			modifier = mkOption {
				default = "super";
				type = types.str;
				description = "Modifier used to set wm keybinds";
			};
			keybinds = {
				terminal = mkOption {
					default = "return";
					type = types.str;
					description = "key used to open terminal";
				};
				movement = {
					left = mkOption {
						default = [ "left" "h" ];
						type = types.listOf types.str;
						description = "key used for moving left";
					};
					right = mkOption {
						default = [ "right" "l" ];
						type = types.listOf types.str;
						description = "key used for moving right";
					};
					up = mkOption {
						default = [ "up" "k" ];
						type = types.listOf types.str;
						description = "key used for moving up";
					};
					down = mkOption {
						default = [ "down" "j" ];
						type = types.listOf types.str;
						description = "key used for moving down";
					};
				};
			};
		};
	};
	config = let
		cfg = config.desktop;
	in {
		wayland.windowManager.hyprland.settings = let
			mod = cfg.modifier;
			terminal = {
				command = "footclient";
				# command = "kitty";
				# command = "wezterm start";
				launch = terminal.command;
				# launch = "foot";
				# launch = "kitty";
				# launch = "wezterm start";
			};
			launcher = "${pkgs.rofi-wayland}/bin/rofi -modi drun,run,combi -show drun";
			pamixer = "${pkgs.pamixer}/bin/pamixer";
		in {
			# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
			bind = [
				"${mod}, Return, exec, ${terminal.command}"
				# "${mod}, Return, exec, wezterm start"
				"${mod} SHIFT, c, killactive, "
				"${mod} SHIFT, q, exit, "
				"${mod}, e, exec, ${terminal.launch} lf"
				# "${mod}, e, exec, wezterm start lf"
				"${mod}, r, exec, ${launcher}"
				"${mod} SHIFT, r, exec, ags quit; ags"
				"${mod}, p, pseudo, " # dwindle"
				"${mod} SHIFT, t, togglesplit, " # dwindle"

				"${mod}, f, fullscreen, 0"
				"${mod} SHIFT, f, fullscreen, 1"
				"${mod} CTRL, f, fullscreenstate, -1 2,"

				"${mod} SHIFT, space, togglefloating,"
				"${mod}, space, cyclenext, floating"
				"${mod} ALT, space, cyclenext, tiled"

				"${mod} SHIFT, minus, movetoworkspace, special"
				"${mod}, minus, togglespecialworkspace,"
				"${mod} ALT, minus, submap, specialWorkspaces"

				"${mod}, u, focusurgentorlast,"

				# Scroll through existing workspaces with mainMod + scroll
				"${mod}, mouse_down, workspace, e+1"
				"${mod}, mouse_up, workspace, e-1"

				", XF86AudioPlay, exec, playerctl play-pause"
				", XF86AudioPause, exec, playerctl play-pause"
				", XF86AudioNext, exec, playerctl next"
				", XF86AudioPrev, exec, playerctl previous"

				", XF86AudioMute, exec, ${pamixer} -t"

				# Screenshot utilities
				", Print, exec, wayshot --stdout | swappy -f -"
				"SHIFT, Print, exec, wayshot -s \"$(slurp)\" --stdout | swappy -f -"
				"CTRL, Print, exec, wayshot --slurp \"$(hyprctl activewindow -j | ${pkgs.jq}/bin/jq '.at as $a| .size as $s| \"\\($a[0]),\\($a[1]) \\($s[0])x\\($s[1])\"' -r)\" --stdout | swappy -f -"

				", XF86MonBrightnessUp, exec, brightnessctl set 1%+"
				", XF86MonBrightnessDown, exec, brightnessctl set 1%-"

				"${mod}, h, movefocus, l"
				"${mod}, j, movefocus, d"
				"${mod}, k, movefocus, u"
				"${mod}, l, movefocus, r"

				"${mod} SHIFT, h, movewindoworgroup, l"
				"${mod} SHIFT, j, movewindoworgroup, d"
				"${mod} SHIFT, k, movewindoworgroup, u"
				"${mod} SHIFT, l, movewindoworgroup, r"

				"${mod}, left, movefocus, l"
				"${mod}, down, movefocus, d"
				"${mod}, up, movefocus, u"
				"${mod}, right, movefocus, r"

				"${mod} SHIFT, left, movewindoworgroup, l"
				"${mod} SHIFT, down, movewindoworgroup, d"
				"${mod} SHIFT, up, movewindoworgroup, u"
				"${mod} SHIFT, right, movewindoworgroup, r"

				"${mod}, TAB, changegroupactive,"
				"${mod} SHIFT, TAB, changegroupactive, b"
				"${mod}, t, togglegroup,"
			] ++ (
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
			#
			# 		"${mod} CTRL, k, hy3:changefocus, raise"
			# 		"${mod} CTRL, j, hy3:changefocus, lower"
			# 	] else []
			# ) ++ (
				builtins.concatLists (
					builtins.genList (
						x: let
							ws = let c = (x + 1) / 10;
							in builtins.toString (x + 1 - (c * 10));
						in [
							"${mod}, ${ws}, workspace, ${builtins.toString (x + 1)}"
							"${mod} SHIFT, ${ws}, movetoworkspace, ${builtins.toString (x + 1)}"
							# (
							# 	if config.wm.hyprland.layout == "hy3" then
							# 		"${mod} SHIFT, ${ws}, hy3:movetoworkspace, ${builtins.toString (x + 1)}"
							# 	else "${mod} SHIFT, ${ws}, hy3:movetoworkspace, ${builtins.toString (x + 1)}"
							# )
						]
					) 10
				)
			);

			binde = [
				# Audio and media controls
				", XF86AudioLowerVolume, exec, ${pamixer} -d 1"
				", XF86AudioRaiseVolume, exec, ${pamixer} -i 1"

				## input
				"CTRL, XF86AudioMute, exec, ${pamixer} --default-source -t"
				"CTRL, XF86AudioLowerVolume, exec, ${pamixer} --default-source -d 1"
				"CTRL, XF86AudioRaiseVolume, exec, ${pamixer} --default-source -i 1"
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
