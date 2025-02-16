{
	...
}: {
	vim.autocomplete = {
		blink-cmp = {
			enable = true;
			setupOpts = {
				# sources = {
				# 	transform_item = 
				# }
			};
			mappings = let
				c = m: "<C-${m}>";
			in {
				close = c "c";
				complete = c "a";
				confirm = c "y";
				next = c "n";
				previous = c "p";
				scrollDocsDown = c "d";
				scrollDocsUp = c "u";
			};
		};
		nvim-cmp = {
			enable = false;
			mappings = let
				c = m: "<C-${m}>";
			in {
				close = c "c";
				complete = c "a";
				confirm = "<tab>";
				next = c "n";
				previous = c "p";
				scrollDocsDown = c "d";
				scrollDocsUp = c "u";
			};
			setupOpts = {
				completion.completeopt = "menu,menuone,noinsert,noselect";
			};
			# sources = {
			# 	nvim = 
			# };
		};
	};
}
