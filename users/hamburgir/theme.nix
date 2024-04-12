{
	config,
	pkgs,
	...
}: {
	wallpaper.desktop = {
		dir = "your_name";
		file = "MitsuhaTakiFirstMeet.jpg";
	};
	stylix = {
		cursor = {
			name = "Catppuccin-Mocha-Blue-Cursors";
			package = pkgs.catppuccin-cursors.mochaBlue;
			# size = 24;
		};

		fonts = {
			monospace = {
				name = "FiraCode Nerd Font Mono Light";
				package = pkgs.fira-code-nerdfont;
			};
			sansSerif = {
				name = "Fira Sans Light";
				# name = "Fira Sans Book";
				package = pkgs.fira;
			};
			serif = {
				name = "Roboto Slab Light";
				# name = "Roboto Slab Regular";
				package = pkgs.roboto-slab;
			};
			sizes = {
				#defaults
				applications = 12;
				desktop = 10;
				popups = 10;

				terminal = 13;
			};
		};

		image = config.wallpaper.desktop.output;

		opacity = {
			#defaults
			desktop = 1.0;
			popups = 1.0;

			terminal = 0.8;
		};
	};
}
