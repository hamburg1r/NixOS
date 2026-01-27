{ config, inputs, pkgs, lib, ... }: {
	imports = [
		./awesome
		./hypr
		./i3
		./niri
		./sway
	];

	options = with lib; {
		desktop = {
			programs = {
				terminal = mkOption {
					type = types.listOf types.str;
					default = [ "kitty" ]; # Common default terminal
					description = "The terminal command to use for desktop environments.";
				};
				app-launcher = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.rofi}/bin/rofi" "-show" "drun" ];
					description = "The application launcher command.";
				};
			};
			actions = {
				volume-up = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.01+" "-l" "1.0" ];
					description = "Command to increase volume.";
				};
				volume-down = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.01-" ];
					description = "Command to decrease volume.";
				};
				volume-mute = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
					description = "Command to toggle volume mute.";
				};
				mic-mute = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.wireplumber}/bin/wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
					description = "Command to toggle microphone mute.";
				};
				mic-volume-up = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "0.01+" "-l" "1.0" ];
					description = "Command to increase microphone volume.";
				};
				mic-volume-down = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.wireplumber}/bin/wpctl" "set-volume" "@DEFAULT_AUDIO_SOURCE@" "0.01-" ];
					description = "Command to decrease microphone volume.";
				};
				mpiris-play-pause = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.playerctl}/bin/playerctl" "play-pause" ];
					description = "Command to toggle play/pause for MPRIS players.";
				};
				mpiris-stop = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.playerctl}/bin/playerctl" "stop" ];
					description = "Command to stop MPRIS players.";
				};
				mpiris-next = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.playerctl}/bin/playerctl" "next" ];
					description = "Command to go to next track for MPRIS players.";
				};
				mpiris-previous = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.playerctl}/bin/playerctl" "previous" ];
					description = "Command to go to previous track for MPRIS players.";
				};
				brightness-up = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "set" "+1%" ];
					description = "Command to increase screen brightness.";
				};
				brightness-down = mkOption {
					type = types.listOf types.str;
					default = [ "${pkgs.brightnessctl}/bin/brightnessctl" "--class=backlight" "set" "1%-" ];
					description = "Command to decrease screen brightness.";
				};
			};
		};
	};
}
