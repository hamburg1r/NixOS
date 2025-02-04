{
	...
}: {
	vim.filetree = {
		# neo-tree = {
		# 	enable = false;
		# };
		nvimTree = {
			enable = true;
			mappings = let
				ldr = m: "<leader>${m}";
			in {
				focus = ldr "tf";
				toggle = ldr "tt";
				findFile = ldr "tg";
				refresh = ldr "tr";
			};
			openOnSetup = false;
			setupOpts = {
				actions = {
					open_file = {
						window_picker = {
							enable = true;
						};
					};
				};
				diagnostics = {
					enable = true;
					severity.min = "WARNING";
					show_on_dirs = true;
					show_on_open_dirs = false;
				};
				git = {
					enable = true;
					disable_for_dirs = [
						"node_modules"
						"result"
					];
				};
				renderer = {
					add_trailing = true;
					full_name = true;
					group_empty = true;
					# https://notashelf.github.io/nvf/options.html#opt-vim.filetree.nvimTree.setupOpts.renderer.highlight_git
				};
				update_focused_file.enable = true;
			};
		};
	};
}
