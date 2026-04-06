{
	config,
	pkgs,
	...
}: {
	imports = [
		./tmux/default.nix
	];

	programs = {
		tmux = {
			enable = true;
		};
		zellij = {
			enable = true;
			enableBashIntegration = false;
			enableZshIntegration = false;
			enableFishIntegration = false;
		};
	};
}
