{
	description = "NixOS CONFIG!!!";

	outputs = {
		self,
		nixpkgs,
		home-manager,
		nixpkgs-stable,
		# nix-on-droid,
		...
	} @ inputs: let
		inherit (self) outputs;
		systems = [
			"aarch64-linux"
			"i686-linux"
			"x86_64-linux"
			"aarch64-darwin"
			"x86_64-darwin"
		];
		forAllSystems = nixpkgs.lib.genAttrs systems;
	in rec {

		packages = forAllSystems (system: import ./pkgs { inherit inputs; pkgs = nixpkgs.legacyPackages.${system}; });
		devShells = forAllSystems (system: import ./shell.nix {pkgs = nixpkgs.legacyPackages.${system};});

		overlays = import ./overlays { inherit inputs; pkgs = nixpkgs.legacyPackages."x86_64-linux"; };

		nixosModules = import ./modules/nixos;
		homeManagerModules = import ./modules/home-manager;

		nixosConfigurations = {
			toaster = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs; system = "x86_64-linux";};
				modules = [
					inputs.wallpapers.nixosModules.default
					./hosts/toaster
				] ++ (builtins.attrValues outputs.nixosModules);
			};
		};

		homeConfigurations = {
			hamburgir = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = {inherit inputs outputs;};
				modules = [
					inputs.wallpapers.homeManagerModules.default

					# inputs.ags.homeManagerModules.default

					# inputs.nixvim.homeManagerModules.nixvim
					# inputs.nvf.homeManagerModules.default

					# inputs.webcord.homeManagerModules.default

					./users/hamburgir
				] ++ (builtins.attrValues outputs.homeManagerModules);
			};
		};

		# nixOnDroidConfigurations = {
		# 	default = nix-on-droid.lib.nixOnDroidConfiguration {
		# 		pkgs = import nixpkgs-stable { system = "aarch64-linux"; };
		# 		modules = [ ./android/default ];
		# 	};
		# };
	};

	inputs = {
		# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable?shallow=1";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable?shallow=1";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11?shallow=1";

		# Home manager
		home-manager.url = "github:nix-community/home-manager?shallow=1";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		# Android
		# nix-on-droid = {
		# 	url = "github:nix-community/nix-on-droid/release-24.05";
		# 	inputs.nixpkgs.follows = "nixpkgs-stable";
		# };


		# catppuccin-sddm = {
		# 	url = "https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip";
		# 	flake = false;
		# };
		grub2-themes = {
			url = "github:vinceliuice/grub2-themes?shallow=1";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		wallpapers = {
			url = "github:h4m6urg1r/wallpapers?shallow=1";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# nixvim = {
		# 	url = "github:nix-community/nixvim";
		# 	# inputs.nixpkgs.follows = "nixpkgs";
		# };
		# nvf = {
		# 	url = "github:NotAShelf/nvf";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };
		#
		# live-server = {
		# 	url = "github:barrett-ruth/live-server.nvim";
		# 	flake = false;
		# };
		# journal-nvim = {
		# 	url = "github:jakobkhansen/journal.nvim";
		# 	flake = false;
		# };
		# autosave-nvim = {
		# 	url = "github:0x00-ketsu/autosave.nvim";
		# 	flake = false;
		# };
		# tiny-code-action = {
		# 	url = "github:rachartier/tiny-code-action.nvim";
		# 	flake = false;
		# };
		# blink-cmp = {
		# 	url = "github:Saghen/blink.cmp";
		# 	flake = false;
		# };


		# webcord.url = "github:fufexan/webcord-flake";


		# ags.url = "github:Aylur/ags";
		# fabricConfig = {
		# 	url = "github:hamburg1r/fabricConfig.git";
		# 	url = "git+file:///home/hamburgir/repo/fabricConfig";
		# };


		nixos-hardware.url = "github:NixOS/nixos-hardware/master?shallow=1";


		# powerlevel10k = {
		# 	url = "github:romkatv/powerlevel10k";
		# 	flake = false;
		# };
	};
}
