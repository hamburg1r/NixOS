{
	inputs,
	pkgs,
	config,
	...
}: {
	imports = [
		inputs.grub2-themes.nixosModules.default
	];
	wallpaper.grub = {
		dir = "miscellaneous";
		file = "GirlStandingDuskWithBirds.jpg";
	};
	boot.loader.grub2-theme = {
		enable = config.boot.loader.grub.enable;
		theme = "tela";
		icon = "color";
		screen = "1080p";
		splashImage = config.wallpaper.grub.output;
		# bootMenuConfig = ;
		# terminalConfig = ;
		# footer = ;
	};
}
