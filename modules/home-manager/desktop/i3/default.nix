{
	config,
	pkgs,
	...
}: {
	xsession.windowManager.i3 = {
		enable = false;
		config = {
			assigns = {
				"4" = [{ class = "^discord"; }];
			};
			keybindings = let
				cfg = config.xsession.windowManager.i3.config;
			in {
				"${cfg.modifier}+Return" = "exec ${cfg.terminal}";
				# "${cfg.modifier}+Shift+q" = "quit";
				"${cfg.modifier}+Shift+q" = "exec i3-nag -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your Desktop session.' -b 'Yes, exit sway' 'i3-msg exit'";
				"${cfg.modifier}+Shift+c" = "kill";
				"${cfg.modifier}+d" = "exec ${cfg.menu}";

				"${cfg.modifier}+h" = "focus left";
				"${cfg.modifier}+j" = "focus down";
				"${cfg.modifier}+k" = "focus up";
				"${cfg.modifier}+l" = "focus right";

				"${cfg.modifier}+Left" = "focus left";
				"${cfg.modifier}+Down" = "focus down";
				"${cfg.modifier}+Up" = "focus up";
				"${cfg.modifier}+Right" = "focus right";

				"${cfg.modifier}+Shift+h" = "move left";
				"${cfg.modifier}+Shift+j" = "move down";
				"${cfg.modifier}+Shift+k" = "move up";
				"${cfg.modifier}+Shift+l" = "move right";

				"${cfg.modifier}+Shift+Left" = "move left";
				"${cfg.modifier}+Shift+Down" = "move down";
				"${cfg.modifier}+Shift+Up" = "move up";
				"${cfg.modifier}+Shift+Right" = "move right";

				"${cfg.modifier}+b" = "splith";
				"${cfg.modifier}+v" = "splitv";
				"${cfg.modifier}+f" = "fullscreen toggle";
				"${cfg.modifier}+a" = "focus parent";

				"${cfg.modifier}+s" = "layout stacking";
				"${cfg.modifier}+w" = "layout tabbed";
				"${cfg.modifier}+e" = "layout toggle split";

				"${cfg.modifier}+Shift+space" = "floating toggle";
				"${cfg.modifier}+space" = "focus mode_toggle";

				"${cfg.modifier}+1" = "workspace number 1";
				"${cfg.modifier}+2" = "workspace number 2";
				"${cfg.modifier}+3" = "workspace number 3";
				"${cfg.modifier}+4" = "workspace number 4";
				"${cfg.modifier}+5" = "workspace number 5";
				"${cfg.modifier}+6" = "workspace number 6";
				"${cfg.modifier}+7" = "workspace number 7";
				"${cfg.modifier}+8" = "workspace number 8";
				"${cfg.modifier}+9" = "workspace number 9";

				"${cfg.modifier}+Shift+1" = "move container to workspace number 1";
				"${cfg.modifier}+Shift+2" = "move container to workspace number 2";
				"${cfg.modifier}+Shift+3" = "move container to workspace number 3";
				"${cfg.modifier}+Shift+4" = "move container to workspace number 4";
				"${cfg.modifier}+Shift+5" = "move container to workspace number 5";
				"${cfg.modifier}+Shift+6" = "move container to workspace number 6";
				"${cfg.modifier}+Shift+7" = "move container to workspace number 7";
				"${cfg.modifier}+Shift+8" = "move container to workspace number 8";
				"${cfg.modifier}+Shift+9" = "move container to workspace number 9";

				"${cfg.modifier}+Shift+minus" = "move scratchpad";
				"${cfg.modifier}+minus" = "scratchpad show";


				"${cfg.modifier}+r" = "mode resize";

				# "Print" = "exec ${pkgs.grim}/bin/grim - | ${pkgs.swappy}/bin/swappy -f -";
				# "Shift+Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.swappy}/bin/swappy -f -";

				"XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 1%+";
				"XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 1%-";

				"Shift+XF86AudioMute" = "exec pamixer --default-source --toggle-mute";
				"XF86AudioMute" = "exec pamixer --toggle-mute";
				"Shift+XF86AudioRaiseVolume" = "exec pamixer --default-source --increase 1 --allow-boost";
				"XF86AudioRaiseVolume" = "exec pamixer --increase 1 --allow-boost";
				"Shift+XF86AudioLowerVolume" = "exec pamixer --default-source --decrease 1 --allow-boost";
				"XF86AudioLowerVolume" = "exec pamixer --decrease 1 --allow-boost";
			};
			modifier = "Mod4";
			terminal = "wezterm";
			startup = [
				{ command = "discord"; }
			];
			workspaceAutoBackAndForth = true;
		};
	};
}
