{ pkgs, ... }: {
	# TODO: checkout
	# dropbar.nvim https://github.com/Bekaboo/dropbar.nvim
	programs.nixvim.plugins.emmet = {
		enable = true;
	};
	programs.nixvim.plugins.lsp = {
		enable = true;
		keymaps = {
			lspBuf = {
				K = "hover";
				gD = "declaration";
				gd = "definition";
				gI = "implementation";
				"<c-k>" = "signature_help";
				"<leader>cwa" = "add_workspace_folder";
				"<leader>cwr" = "remove_workspace_folder";
				"<leader>cD" = "type_definition";
				"<leader>cR" = "rename";
				"<leader>cr" = "references";
				"<leader>ca" = "code_action";
			};
			diagnostic = {
				"<leader>cd" = "open_float";
				"<leader>cll" = "setloclist";
				"<leader>clq" = "setqflist";
			};
		};
		onAttach = ''
		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end
		'';
		servers = {
			bashls.enable = true;
			dartls.enable = true;
			html.enable = true;
			lua-ls.enable = true;
			nixd = {
				enable = true;
				settings = {
					options = {
						toaster.expr = ''(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.toaster.options'';
						hamburgir.expr = ''(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options'';
					};
				};
			};
			pylsp.enable = true;
			ruff-lsp.enable = true;
			tsserver.enable = true;
		};
	};
	# programs.nixvim = {
	# 	extraPlugins = [
	# 		pkgs.vimPlugins.flutter-tools-nvim
	# 		pkgs.vimPlugins.plenary-nvim
	# 	];
	# 	extraConfigLua = ''
	# 	require("flutter-tools").setup({
	# 		ui = {
	# 			notification_style = 'plugin',
	# 		},
	# 		flutter_lookup_cmd = "dirname $(which flutter)",
	# 		widget_guides = {
	# 			enabled = true,
	# 		},
	# 		dev_log = {
	# 			enabled = true,
	# 			notify_error = true,
	# 		}
	# 	})
	# 	'';
	# };
}
