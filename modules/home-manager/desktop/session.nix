{ config, inputs, pkgs, lib, ... }: {
	imports = [
		./awesome
		./hypr
		./i3
		./niri
		./sway
	];

	options = with lib; {
		desktop.programs = {
			terminal = mkOption {
				type = types.str;
				default = "kitty"; # Common default terminal
				description = "The terminal command to use for desktop environments.";
			};
			app-launcher = mkOption {
				type = types.str;
				default = "${pkgs.rofi}/bin/rofi -show drun";
				description = "The application launcher command.";
			};
		};
	};
}
