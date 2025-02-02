{ ... }: {
	programs.nixvim.plugins = {
		rainbow-delimiters = {
			enable = true;
		};
		treesitter = {
			enable = true;
			settings = {
				indent.enable = true;
				incremental_selection.enable = true;
			};
		};
	};
}
