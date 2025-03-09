{
	lib,
	...
}: let
	inherit (lib.generators) mkLuaInline;
in {
	vim.autocomplete = {
		blink-cmp = {
			enable = true;
			setupOpts = {
				completion = {
					trigger = {
						show_on_keyword = true;
						show_on_trigger_character = true;
						show_on_insert_on_trigger_character = true;

					};
					accept = {
						auto_brackets.enabled = false;
						dot_repeat = true;
						create_undo_point = true;
					};
					list = {
						selection = {
							auto_insert = true;
						};
					};
					menu = {
						auto_show = true;
						draw = {
							columns = [
								[ "kind_icon" ]
								[ "label" "label_description" (mkLuaInline ''gap = 1'') ]
								[ "kind" ]
							];
							treesitter = [ "lsp" ];
						};
					};
					documentation = {
						auto_show = true;
						auto_show_delay_ms = 250;
					};
				};
				snippets = {
					preset = "luasnip";
				};
				signature = {
					enabled = true;
					# trigger = {
					# 	show_on_insert = false;
					# };
				};
				sources = {
					default = [
						"snippets"
						"lsp"
						"path"
					];
					providers = {
						# snippets = {
						# 	name = "Snippets";
						# 	module = "blink.cmp.sources.snippets";
						# 	score_offset = 10;
						# };
						# lsp = {
						# 	name = "LSP";
						# 	module = "blink.cmp.sources.lsp";
						# 	fallbacks = [ "buffer" ];
						# 	score_offset = 9;
						# };
					# 	buffer = {
					# 		opts = {
					# 			get_bufnrs = mkLuaInline ''
					# 				function()
					# 					return vim.tbl_filter(function(bufnr)
					# 						return vim.bo[bufnr].buftype == '''
					# 					end, vim.api.nvim_list_bufs())
					# 				end
					# 			'';
					# 		};
					# 	};
					};
				# 	transform_item = 
				};
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
