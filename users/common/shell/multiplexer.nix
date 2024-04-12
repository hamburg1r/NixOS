{
	config,
	...
}: {
	programs = {
		zellij = {
			enableBashIntegration = config.programs.bash.enable;
			enableZshIntegration = config.programs.zsh.enable;
			enableFishIntegration = config.programs.fish.enable;
		};
	};
}
