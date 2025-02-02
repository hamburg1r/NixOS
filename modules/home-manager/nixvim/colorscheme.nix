{
	inputs,
	config,
	...
}: {
	programs.nixvim.colorschemes = {
		catppuccin = {
			enable = true;
			settings = {
				flavour = "mocha";
				show_end_of_buffer = true;
				transparent_background = true;
				integrations = let
					p = name: config.programs.nixvim.plugins.${name}.enable;
				in {
					cmp = p "cmp";
					blink_cmp = p "blink-cmp";
					# dashboard = p "dashboard";
					fidget = p "fidget";
					# gitgutter = p "gitgutter";
					# gitsigns = true;
					# harpoon = true;
					# hop = true;
					# neogit = true;
					# neotree = true;
					noice = p "noice";
					# notifier = true;
					notify = p "notify";
					# nvimtree = true;
					treesitter = p "treesitter";
					treesitter_context = p "treesitter-context";
					# rainbow_delimiter = p "rainbow-delimiter";
					# ufo = true;
					which_key = p "which-key";
					window_picker = true;

					dap = {
						enable_ui = true;
						enabled = true;
					};

					indent_blankline = {
						enabled = true;
						colored_indent_levels = true;
					};

					native_lsp.enabled = true;

					navic.enabled = true;

					telescope = {
						enabled = p "telescope";
					};
				};
			};
		};
	};
}
