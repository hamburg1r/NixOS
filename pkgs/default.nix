# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
	inputs,
	pkgs,
	...
}: let
	nvf-config = inputs.nvf.lib.neovimConfiguration {
		inherit pkgs;
		modules = [
			# {
			# 	config.vim.theme.name = "catppuccin";
			# }
			../modules/home-manager/nvf
		];
	};
in rec {
	# example = pkgs.callPackage ./example { };
	nvf = nvf-config.neovim;
	default = nvf;
}
