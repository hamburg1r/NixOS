{
	pkgs,
	...
}: {
	home.packages = [
		pkgs.nvf # Saves memory
	];
	programs.nvf.enable = false;
	programs.nixvim.enable = false;
}
