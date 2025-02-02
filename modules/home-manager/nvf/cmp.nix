{
	...
}: {
	vim.autocomplete = {
		nvim-cmp = {
			enable = true;
			mappings = let
				c = m: "<C-${m}";
			in {
				close = c "c";
				complete = c "CR";
				confirm = null;
				next = c "n";
				previous = c "p";
				scrollDocsDown = c "d";
				scrollDocsUp = c "u";
			};
			setupOpts = {
				# completion.completeopt = "menu,menuone,noinsert";
			};
			sources = {};
		};
	};
}
