{
	...
}: {
	vim.languages = {
		enableTreesitter = true;
		bash.treesitter.enable = true;
		clang.treesitter.enable = true;
		css.treesitter.enable = true;
		dart.treesitter.enable = true;
		html.treesitter.enable = true;
		java.treesitter.enable = true;
		lua.treesitter.enable = true;
		markdown.treesitter.enable = true;
		nix.treesitter.enable = true;
		php.treesitter.enable = true;
		python.treesitter.enable = true;
		# sql.treesitter.enable = true;
		ts.treesitter.enable = true;
		typst.treesitter.enable = true;
	};
	vim.treesitter = {
		# enable = true;
		autotagHtml = true;
		context = {
			enable = true;
			setupOpts = {
				# line_numbers = false;
				# mode = "topline"; # "cursor" "topline"
				multiline_threshold = 10;
			};
		};
		fold = true;
	};
}
