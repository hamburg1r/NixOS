{
	config,
	pkgs,
	lib,
	...
}: {
	specialisation = rec {
		dark.configuration = {
			stylix = {
				polarity = "dark";
				base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
			};
		};
		light.configuration = {
			stylix = {
				polarity = "light";
				base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
			};
		};
		dark-zathuraUnmodified.configuration = dark.configuration // {
			stylix.targets.zathura.enable = false;
		};
		light-zathuraUnmodified.configuration = light.configuration // {
			stylix.targets.zathura.enable = false;
		};
	};
}
