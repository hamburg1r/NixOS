{
	lib,
	pkgs,
	...
}: {
	stylix = {
		cursor = {
			name = lib.mkDefault "Catppuccin-Mocha-Blue-Cursors";
			package = lib.mkDefault pkgs.catppuccin-cursors.mochaBlue;
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
