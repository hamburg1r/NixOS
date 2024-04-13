{
	config,
	pkgs,
	...
}:
# with pkgs.lib; let
# recursiveMerge = attrList:
# 	let f = attrPath:
# 		zipAttrsWith (n: values:
# 		if tail values == []
# 			then head values
# 		else if all isList values
# 			then unique (concatLists values)
# 		else if all isAttrs values
# 			then f (attrPath ++ [n]) values
# 		else last values
# 		);
# 	in f [] attrList;
# in let
# 		stolen = import ./dunst/dunstrc_end-4_dots-hyprland.nix;
# 		custom = import ./dunst/dunstrc.nix { inherit pkgs; };
# 		theme = import ./dunst/catppuccinMocha.nix;
# 		mergedConf = recursiveMerge [ stolen custom theme ];
# in
{
	services = {
		dunst = {
			inherit (config.gtk) iconTheme;
			enable = true;
			settings = {
				global = {
					monitor = 0;
					follow = "mouse";
					origin = "top-right";
					# offset = "20x73";
					# geometry = "280x50-20+200";
					width = 280;
					# height = 50;
					# indicate_hidden = "no";
					shrink = "no";
					separator_height = 3;
					padding = 20;
					horizontal_padding = 20;
					frame_width = 2;
					sort = "no";
					line_height = 4;
					markup = "full";
					alignment = "left";
					show_age_threshold = 60;
					word_wrap = "yes";
					ignore_newline = "no";
					stack_duplicates = "false";
					hide_duplicate_count = "yes";
					show_indicators = "no";
					icon_position = "left";
					# icon_path = "/home/end/.config/eww/images/linageOS Icons/1G.png";
					max_icon_size = 48;
					sticky_history = "no";
					history_length = 20;
					browser = "firefox";
					always_run_script = "true";
					title = "Dunst";
					class = "Dunst";
					# corner_radius = 10;
					format = "<b>%s</b>\\n%b\\n<i>%a</i>";
					idle_threshold = 0;
					dmenu = "${pkgs.rofi-wayland}/bin/rofi-wayland -dmenu";
				};
				# shortcuts = {
				# 	close = "ctrl+shift+space";
				# 	close_all = "ctrl+shift+space";
				# 	history = "ctrl+grave";
				# 	context = "ctrl+shift+period";
				# };
				# urgency_low = {
				# 	timeout = 4;
				# 	background = "#1A1B26";
				# 	foreground = "#90D1F6";
				# 	frame_color = "#AEE5FA";
				# };
				# urgency_normal = {
				# 	timeout = 8;
				# 	background = "#1A1B26";
				# 	foreground = "#90D1F6";
				# 	frame_color = "#AEE5FA";
				# };
				# urgency_critical = {
				# 	timeout = 0;
				# 	background = "#191919";
				# 	foreground = "#EEAA00";
				# 	frame_color = "#EEAA00";
				# };
			};
			# settings = {
			# 	global = {
			# 		width = 300;
			# 		height = 300;
			# 		offset = "30x50";
			# 		origin = "top-right";
			# 		transparency = 10;
			# 		frame_color = "#eceff1";
			# 		# font = 
			# 	};
			# 	urgency_normal = {
			# 		background = "#37474f";
			# 		foreground = "#eceff1";
			# 		timeout = 30;
			# 	};
			# };
		};
	};
}
