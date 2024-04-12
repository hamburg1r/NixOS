{
	config,
	...
}: {
	programs = {
		zellij = {
			enable = true;
		};
	};

	home.file."Zellij" = {
		enable = config.programs.zellij.enable;
		source = ./zellij;
		target = ".config/zellij";
	};
	stylix.targets.zellij.enable = false;
}
