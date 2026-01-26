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
					default = [ [] ["return"] ];
					type = types.listOf types.raw;
					description = "key used to open terminal, format: [ [\"modifier1\", ...], [\"key\"] ]";
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
					first = mkOption {
						default = [ "home" "a" ];
						type = types.listOf types.str;
						description = "key used for moving to the first column/window";
					};
					last = mkOption {
						default = [ "end" "f" ];
						type = types.listOf types.str;
						description = "key used for moving to the last column/window";
					};
				};
				app-launcher = mkOption {
					default = [ [] ["r"] ];
					type = types.listOf types.raw;
					description = "key used to open app launcher, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				show-help = mkOption {
					default = [ ["Shift"] ["Slash"] ];
					type = types.listOf types.raw;
					description = "key used to show help overlay, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				screenshot = mkOption {
					default = [ ["Shift"] ["s"] ];
					type = types.listOf types.raw;
					description = "key used to take screenshot, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				close-window = mkOption {
					default = [ ["Shift"] ["c"] ];
					type = types.listOf types.raw;
					description = "key used to close window, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				fullscreen = mkOption {
					default = [ [] ["f"] ];
					type = types.listOf types.raw;
					description = "key used to fullscreen window, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				toggle-windowed-fullscreen = mkOption {
					default = [ ["Control"] ["f"] ];
					type = types.listOf types.raw;
					description = "key used to toggle windowed fullscreen, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
				quit = mkOption {
					default = [ ["Shift"] ["q"] ];
					type = types.listOf types.raw;
					description = "key used to quit session, format: [ [\"modifier1\", ...], [\"key\"] ]";
				};
			};
		};
	};
}
