{
	config,
	pkgs,
	lib,
	...
}: {
	wallpaper = {
		desktop = {
			dir = "your_name";
			file = "MitsuhaTakiFirstMeet.jpg";
		};
		hyprland = {
			blur.enabled = true;
		};
	};
	# stylix = {
	# 	enable = false;
	# 	polarity = lib.mkDefault "dark";
	# 	base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
	# 	cursor = {
	# 		name = "catppuccin-mocha-blue-cursors";
	# 		package = pkgs.catppuccin-cursors.mochaBlue;
	# 		# size = 24;
	# 	};
	#
	# 	fonts = {
	# 		monospace = {
	# 			name = "FiraCode Nerd Font Mono";
	# 			package = pkgs.nerd-fonts.fira-code;
	# 		};
	# 		sansSerif = {
	# 			name = "Fira Sans Light";
	# 			# name = "Fira Sans Book";
	# 			package = pkgs.fira;
	# 		};
	# 		serif = {
	# 			name = "Roboto Slab Light";
	# 			# name = "Roboto Slab Regular";
	# 			package = pkgs.roboto-slab;
	# 		};
	# 		sizes = {
	# 			#defaults
	# 			applications = 12;
	# 			desktop = 10;
	# 			popups = 10;
	#
	# 			terminal = 12;
	# 		};
	# 	};
	#
	# 	image = config.wallpaper.desktop.output;
	#
	# 	opacity = {
	# 		#defaults
	# 		desktop = 1.0;
	# 		popups = 1.0;
	#
	# 		terminal = 0.8;
	# 	};
	# 	targets = {
	# 		nixvim.enable = false;
	# 		fzf.enable = false;
	# 	};
	# };

	userTheme.cursors = {
		name = "catppuccin-mocha-blue-cursors";
		package = pkgs.catppuccin-cursors.mochaBlue;
		size = 24;
	};

	theme.enable = true;
}
