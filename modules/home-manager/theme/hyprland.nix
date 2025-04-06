{
	lib,
	config,
	...
}: with lib; let
	colors = config.userTheme.colors;
in {
	options.userTheme.hyprland = {
		activeBorderColor = mkOption {
			type = types.str;
			default = colors.blue;
			description = "Color of active window borders";
		};
		inactiveBorderColor = mkOption {
			type = types.str;
			default = colors.surface1;
			description = "Color of inactive window borders";
		};
		urgentBorderColor = mkOption {
			type = types.str;
			default = colors.red;
			description = "Color of urgent window borders";
		};
		floatingBorderColor = mkOption {
			type = types.str;
			default = colors.mauve;
			description = "Color of floating window borders";
		};
		background = mkOption {
			type = types.str;
			default = colors.base;
			description = "Background color of Hyprland elements";
		};
		textColor = mkOption {
			type = types.str;
			default = colors.text;
			description = "Default text color in Hyprland overlays";
		};
		shadowColor = mkOption {
			type = types.str;
			default = colors.mantle;
			description = "Shadow color for windows";
		};
		shadowRange = mkOption {
			type = types.int;
			default = 5;
			description = "Shadow range";
		};
	};

	config = let
		colors = config.userTheme.colors;
		theme = config.userTheme.hyprland;
		wayland = config.wayland.windowManager.hyprland.settings;
	in lib.mkIf config.theme.enable {
		wayland.windowManager.hyprland = {
			enable = true;
			settings = {
				general = {
					border_size = 2;
					"col.active_border" = "rgba(${theme.activeBorderColor}ff)";
					"col.inactive_border" = "rgba(${theme.inactiveBorderColor}ff)";
				};

				decoration.shadow = {
					# big shadow of doom required
					enabled = true;
					range = builtins.toString theme.shadowRange;
					# shadow_range = 24;
					render_power = 1; # TODO
					# shadow_render_power = 3;
					sharp = false; # TODO
					ignore_window = true;
					# shadow_ignore_window = false;
					color = "rgba(${theme.shadowColor}88)";
					# color_inactive = ; # TODO
					offset = "${builtins.toString theme.shadowRange} ${builtins.toString theme.shadowRange}";
					# offset = [ 0 0 ]; # TODO
					# scale = 1.0;
				};

				misc = {
					background_color = "rgba(${theme.background}ff)";
				};

				group = {
					"col.border_active" = "rgba(${colors.blue}ff)";
					"col.border_inactive" = "rgba(${colors.surface1}ff)";
					"col.border_locked_active" = "rgba(${colors.mauve}ff)";
					"col.border_locked_inactive" = "rgba(${colors.overlay1}ff)";
					groupbar = {
						enabled = true;
						font_family = config.userTheme.fonts.monospace;
						font_size = 8;
						height = 14;
						# indicator_height = 3;
						render_titles = true;
						# rounding = 1;
						# gradient_rounding = 2;
						# round_only_edges = true;
						# gradient_round_only_edges = true;
						text_color = "0x${colors.text}ff";
						# gaps_in = 2;
						# gaps_out = 2;

						"col.active" = "rgba(${colors.blue}ff)";
						"col.inactive" = "rgba(${colors.surface1}ff)";
						"col.locked_active" = "rgba(${colors.mauve}ff)";
						"col.locked_inactive" = "rgba(${colors.overlay1}ff)";
					};
				};
			};
		};
	};
}
