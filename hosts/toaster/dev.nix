{
	pkgs,
	...
}: {
	environment.systemPackages = [
		pkgs.devenv
	];
	programs.direnv = {
		enable = true;
	};
}
