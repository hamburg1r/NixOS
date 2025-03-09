{
	pkgs,
	...
}: {
	home.packages = [
		# pkgs.nvf # Saves memory
		pkgs.neovim-with-lsp
	];
	# programs.nvf.enable = false;
	# programs.nixvim.enable = false;
}
