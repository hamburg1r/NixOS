# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
	inputs,
	pkgs,
	...
}: let
	overlays = import ../overlays { inherit inputs; };
	pkgs' = pkgs.extend overlays.additions;
	nvf-config = inputs.nvf.lib.neovimConfiguration {
		pkgs = pkgs';
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
