{
	# pkgs,
	...
}: {
	vim.snippets = {
		luasnip = {
			enable = true;
			# providers = [
			# 	pkgs.friendly-snippets
			# ];
		};
	};
}
