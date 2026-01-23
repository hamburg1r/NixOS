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
				app-launcher = mkOption {
					default = "r";
					type = types.str;
					description = "key used to open app launcher";
				};
			};
		};
	};
}
