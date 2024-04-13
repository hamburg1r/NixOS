{
	lib,
	pkgs,
	...
}: {
	gtk = {
		enable = true;
		iconTheme = {
			package = lib.mkDefault pkgs.papirus-icon-theme;
			name = lib.mkDefault "Papirus-Dark";
		};
	};
	stylix = {
		cursor = {
			name = lib.mkDefault "Catppuccin-Mocha-Dark-Cursors";
			package = lib.mkDefault pkgs.catppuccin-cursors.mochaDark;
			# size = lib.mkDefault 24;
		};
		fonts = {
			emoji = {
				name = lib.mkDefault "Noto Color Emoji";
				package = lib.mkDefault pkgs.noto-fonts-color-emoji;
			};
			monospace = {
				name = lib.mkDefault "FiraCode Nerd Font Mono Regular";
				package = lib.mkDefault pkgs.fira-code-nerdfont;
			};
			sansSerif = {
				name = lib.mkDefault "Fira Sans Book";
				package = lib.mkDefault pkgs.fira;
			};
			serif = {
				name = lib.mkDefault "Roboto Slab Regular";
				package = lib.mkDefault pkgs.roboto-slab;
			};
		};
	};
}
