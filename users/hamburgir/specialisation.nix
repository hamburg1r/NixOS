{
	config,
	...
}: {
	specialization = {
		dark.configuration = {
			stylix.polarity = "dark";
		};
		light.configuration = {
			stylix.polarity = "light";
		};
		dark-zathuraUnmodified.configuration = config.specialization.dark.configuration // {
			stylix.targets.zathura.enable = false;
		};
		light-zathuraUnmodified.configuration = config.specialization.light.configuration // {
			stylix.targets.zathura.enable = false;
		};
	};
}
