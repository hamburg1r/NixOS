{
	pkgs,
	...
}: {
	# home.packages = [ pkgs.nvf ];
	programs.nvf.enable = true;
	programs.nixvim.enable = false;
}
