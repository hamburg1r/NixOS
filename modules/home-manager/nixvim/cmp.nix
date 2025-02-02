{
	lib,
	config,
	...
}: {
	programs.nixvim.plugins = {
		blink-cmp = {
			enable = false;
			# lazyLoad = {
			# 	enable = true;
			# 	settings = {
			# 		event = [
			# 			"UIEnter"
			# 		];
			# 	};
			# };
		};
		cmp = {
			enable = ! config.programs.nixvim.plugins.blink-cmp.enable;
			settings = {
				preselect = "Item";
				cmdline.completion.completeopt = "menu,menuone,noinsert";
				mapping = let luasnip = "require('luasnip')"; in {
					__raw = ''{
						[ "<C-Tab>" ] = cmp.mapping.complete(),
						[ "<C-c>" ] = cmp.mapping.close(),
						[ "<C-d>" ] = cmp.mapping.scroll_docs(1),
						[ "<C-u>" ] = cmp.mapping.scroll_docs(-1),
						[ "<CR>" ] = cmp.mapping.confirm({ select = true }),
						[ "<C-p>" ] = cmp.mapping(function(fallback)
								if cmp.visible() then
									cmp.select_prev_item()
								-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
								-- that way you will only jump inside the snippet region
								elseif ${luasnip}.jumpable(-1) then
									${luasnip}.jump(-1)
								else
									fallback()
								end
							end,
							{"i", "s"}),
						[ "<C-n>" ] = cmp.mapping(function(fallback)
								local has_words_before = function()
									unpack = unpack or table.unpack
									local line, col = unpack(vim.api.nvim_win_get_cursor(0))
									return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
								end
								if cmp.visible() then
									cmp.select_next_item()
								-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
								-- that way you will only jump inside the snippet region
								elseif ${luasnip}.expand_or_locally_jumpable() then
									${luasnip}.expand_or_jump()
								elseif has_words_before() then
									cmp.complete()
								else
									fallback()
								end
							end,
							{"i", "s"}),
					}'';
				};
				snippet.expand = "luasnip";
				sources = [
					{
						name = "nvim_lsp";
						priority = 10000000000;
						# group_index = 1;
					}
					{
						name = "luasnip";
						priority = 100000;
						# group_index = 1;
					}
					{
						name = "fuzzy_path";
						priority = 3;
						# group_index = 1;
					}
					# {
					# 	name = "path";
					# 	priority = 3;
					# 	# group_index = 1;
					# }
					{
						name = "fuzzy_buffer";
						priority = 0;
						# group_index = 3;
					}
					# {
					# 	name = "buffer";
					# 	priority = 1;
					# 	# group_index = 3;
					# }
					{
						name = "calc";
						priority = 5;
						# group_index = 1;
					}
					{
						name = "spell";
						priority = 0;
						# group_index = 1;
					}
					{
						name = "nvim_lsp_signature_help";
						priority = 7;
						# group_index = 1;
					}
				];
			};
		};
	};
	programs.nixvim.extraConfigLuaPost = lib.mkIf config.programs.nixvim.plugins.cmp.enable ''
		-- If you want insert `(` after select function or method item
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		local cmp = require('cmp')
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)
	'';
}
