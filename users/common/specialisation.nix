{
	config,
	pkgs,
	lib,
	...
}: {
	specialisation = rec {
		dark.configuration = lib.mkDefault {
			stylix.polarity = "dark";
			gtk = {
				iconTheme = {
					package = pkgs.papirus-icon-theme;
					name = "Papirus-Dark";
				};
			};
		};
		light.configuration = lib.mkDefault {
			stylix.polarity = "light";
			gtk = {
				iconTheme = {
					package = pkgs.papirus-icon-theme;
					name = "Papirus-Light";
				};
			};
		};
	};
}
