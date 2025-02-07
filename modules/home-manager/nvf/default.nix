{
	...
}: {
	imports = [
		./cmp.nix
		./colorscheme.nix
		./debugging.nix
		./filemanager.nix
		./keybinds.nix
		./languages.nix
		./lsp.nix
		./notify.nix
		./options.nix
		./snippets.nix
		./telescope.nix
		./treesitter.nix
		./ui.nix
		./utils.nix
	];
	vim.lazy.enable = true;
}
