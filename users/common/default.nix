{
	config,
	lib,
	...
}: {
	imports = [
		./gui
		./shell
		./theme.nix
		./specialisation.nix
	];
	home = {
		homeDirectory = lib.mkDefault "/home/${config.home.username}";
		stateVersion = lib.mkDefault "24.05";
	};
	programs.nh = {
		enable = true;
		clean = {
			enable = true;
			extraArgs = "--nogcroots --keep-since 3d --keep 5";
			dates = "daily";
		};
	};
}
