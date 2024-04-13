{
	...
}: {
	programs.kitty = {
		shellIntegration = {
			mode = "no-rc no-cursor";
		};
		settings =
		# let
		# 	catppuccin-mocha = {
		# 		foreground = "#CDD6F4";
		# 		background = "#1E1E2E";
		# 		selection_foreground = "#1E1E2E";
		# 		selection_background = "#F5E0DC";
		#
		# 		cursor = "#F5E0DC";
		# 		cursor_text_color = "#1E1E2E";
		#
		# 		url_color = "#F5E0DC";
		#
		# 		active_border_color = "#B4BEFE";
		# 		inactive_border_color = "#6C7086";
		# 		bell_border_color = "#F9E2AF";
		#
		# 		wayland_titlebar_color = "#1E1E2E";
		# 		macos_titlebar_color = "#1E1E2E";
		#
		# 		active_tab_foreground = "#11111B";
		# 		active_tab_background = "#CBA6F7";
		# 		inactive_tab_foreground = "#CDD6F4";
		# 		inactive_tab_background = "#181825";
		# 		tab_bar_background = "#11111B";
		#
		# 		mark1_foreground = "#1E1E2E";
		# 		mark1_background = "#B4BEFE";
		# 		mark2_foreground = "#1E1E2E";
		# 		mark2_background = "#CBA6F7";
		# 		mark3_foreground = "#1E1E2E";
		# 		mark3_background = "#74C7EC";
		#
		# 		color0 = "#45475A";
		# 		color8 = "#585B70";
		#
		# 		color1 = "#F38BA8";
		# 		color9 = "#F38BA8";
		#
		# 		color2 = "#A6E3A1";
		# 		color10 = "#A6E3A1";
		#
		# 		color3 = "#F9E2AF";
		# 		color11 = "#F9E2AF";
		#
		# 		color4 = "#89B4FA";
		# 		color12 = "#89B4FA";
		#
		# 		color5 = "#F5C2E7";
		# 		color13 = "#F5C2E7";
		#
		# 		color6 = "#94E2D5";
		# 		color14 = "#94E2D5";
		#
		# 		color7 = "#BAC2DE";
		# 		color15 = "#A6ADC8";
		# 	};
		# in
		{
		# 	inherit (catppuccin-mocha)
		# 		foreground
		# 		background
		# 		selection_foreground
		# 		selection_background
		# 		cursor
		# 		cursor_text_color
		# 		url_color
		# 		active_border_color
		# 		inactive_border_color
		# 		bell_border_color
		# 		wayland_titlebar_color
		# 		macos_titlebar_color
		# 		active_tab_foreground
		# 		active_tab_background
		# 		inactive_tab_foreground
		# 		inactive_tab_background
		# 		tab_bar_background
		# 		mark1_foreground
		# 		mark1_background
		# 		mark2_foreground
		# 		mark2_background
		# 		mark3_foreground
		# 		mark3_background
		# 		color0
		# 		color8
		# 		color1
		# 		color9
		# 		color2
		# 		color10
		# 		color3
		# 		color11
		# 		color4
		# 		color12
		# 		color5
		# 		color13
		# 		color6
		# 		color14
		# 		color7
		# 		color15;
		# 	background_opacity = "0.8";
			cursor_blink_interval = 0;
		};
	};
}
