{
	pkgs,
	...
}: {
	home = {
		packages = [
			# pkgs.nvf # Saves memory
			pkgs.neovim
		];
		shellAliases = {
			vi = "nvim";
			vim = "nvim";
		};
	};
	# programs.nvf.enable = false;
	# programs.nixvim.enable = false;
}
