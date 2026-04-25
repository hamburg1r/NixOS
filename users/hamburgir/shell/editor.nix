{
	inputs,
	pkgs,
	...
}: {
	home = {
		packages = [
			# pkgs.nvf # Saves memory
			pkgs.neovim
			inputs.mcp-hub.packages."x86_64-linux".default
		];
		shellAliases = {
			vi = "nvim";
			vim = "nvim";
		};
	};
	# programs.nvf.enable = false;
	# programs.nixvim.enable = false;
}
