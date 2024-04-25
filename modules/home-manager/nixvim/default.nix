{ inputs, config, pkgs, ... }: {
	imports = [
		./cmp.nix
		./colorscheme.nix
		./filemanager.nix
		./keymaps.nix
		./live-server.nix
		./lsp.nix
		./options.nix
		./snippets.nix
		./statusline.nix
		./telescope.nix
		./treesitter.nix
		./ui.nix
		./utils.nix
	];
	programs.nixvim = {
		enable = true;
		extraPackages = with pkgs; [
			fd
			ripgrep
		];
		viAlias = true;
		vimAlias = true;
	};
}
