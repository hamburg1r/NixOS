{
	pkgs,
	...
}: {
	vim.snippets = {
		luasnip = {
			enable = true;
			providers = [
				pkgs.vimPlugins.friendly-snippets
			];
		};
	};
}
