{
	lib,
	pkgs,
	config,
	...
}: let
	inherit (lib) mkOption;
	inherit (lib.types) str;
	inherit (lib.nvim.types) mkPluginSetupOption;
in {
	options.vim.tiny-code-action.nvim = {
		# TODO: Add more shit
		setupOpts = mkPluginSetupOption "autosave" {
			backend = mkOption {
				type = str;
				default = "delta";
				description = "Backend for preview";
			};
		};
	};
	config.vim = {
		lsp = {
			enable = true;
			lspconfig.enable = true;
			lightbulb.enable = true;
			lspSignature.enable = !config.vim.autocomplete.blink-cmp.enable;
			lspkind.enable = true;
			nvim-docs-view.enable = false;
			trouble.enable = false;
			mappings = let
				c = m: "<leader>c${m}";
			in {
				# codeAction = c "a";
				codeAction = null;
				hover = c "h";
				documentHighlight = c "H";

				goToDeclaration = c "gD";
				goToDefinition = c "gd";
				goToType = c "gt";

				listDocumentSymbols = c "S";
				listImplementations = c "gi";
				listReferences = c "gr";

				addWorkspaceFolder = c "wa";
				removeWorkspaceFolder = c "wr";
				listWorkspaceFolders = c "wl";
				listWorkspaceSymbols = c "ws";

				nextDiagnostic = c "gn";
				previousDiagnostic = c "gp";
				openDiagnosticFloat = c "df";

				signatureHelp = c "s";
				renameSymbol = c "r";

				format = c "f";
				toggleFormatOnSave = c "tf";
			};
		};

		languages = {
			enableLSP = true;
			enableTreesitter = true;
			# bash.lsp.enable = true;
			clang.lsp = {
				enable = true;
				# package = ;
				server = "ccls";
			};
			# css.lsp.enable = true;
			dart.lsp.enable = false;
			# html.lsp.enable = true;
			# java.lsp.enable = true;
			# lua.lsp.enable = true;
			# markdown.lsp.enable = true;
			nix.lsp = {
				enable = true;
			};
			# php.lsp.enable = true;
			python.lsp.enable = true;
			# sql.lsp.enable = true;
			# ts.lsp.enable = true;
			typst.lsp.enable = true;
		};

		lazy.plugins = {
			${pkgs.vimPlugins.tiny-code-action.pname} = {
				package = pkgs.vimPlugins.tiny-code-action;
				event = [ "LspAttach" ];
				inherit (config.vim.tiny-code-action.nvim) setupOpts;
				setupModule = "tiny-code-action";
			};
		};
	};
}
