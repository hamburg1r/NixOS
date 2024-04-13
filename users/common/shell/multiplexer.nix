{
	config,
	lib,
	...
}: {
	programs = {
		zellij = {
			enableBashIntegration = lib.mkDefault config.programs.bash.enable;
			enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
			enableFishIntegration = lib.mkDefault config.programs.fish.enable;
		};
	};
}
