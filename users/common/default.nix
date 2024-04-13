{
	config,
	lib,
	...
}: {
	imports = [
		./gui
		./shell
		./theme.nix
	];
	home = {
		homeDirectory = lib.mkDefault "/home/${config.home.username}";
		stateVersion = lib.mkDefault "24.05";
	};
}
