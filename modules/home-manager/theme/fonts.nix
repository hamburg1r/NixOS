{
	lib,
	pkgs,
	...
}: with lib; {
	options.userTheme.fonts = {
		emoji = mkOption {
			type = types.str;
			default = "Noto Color Emoji";
			description = "Emoji font name.";
			example = "Noto Color Emoji";
		};

		monospace = mkOption {
			type = types.str;
			default = "FiraCode Nerd Font Mono";
			description = "Monospace font name.";
			example = "FiraCode Nerd Font Mono";
		};

		sansSerif = mkOption {
			type = types.str;
			default = "Fira Sans Light";
			description = "Sans-serif font name.";
			example = "Fira Sans Light";
		};

		serif = mkOption {
			type = types.str;
			default = "Roboto Slab Light";
			description = "Serif font name.";
			example = "Roboto Slab Light";
		};

		packages = mkOption {
			type = types.listOf types.package;
			default = [
				pkgs.nerd-fonts.fira-code
				pkgs.fira
				pkgs.roboto-slab
				pkgs.noto-fonts-color-emoji
			];
			description = "Font packages to install.";
		};
	};

	config = {};
}
