{
	config,
	...
}: {
	specialisation = rec {
		dark.configuration = {
			stylix.polarity = "dark";
		};
		light.configuration = {
			stylix.polarity = "light";
		};
		dark-zathuraUnmodified.configuration = dark.configuration // {
			stylix.targets.zathura.enable = false;
		};
		light-zathuraUnmodified.configuration = light.configuration // {
			stylix.targets.zathura.enable = false;
		};
	};
}
