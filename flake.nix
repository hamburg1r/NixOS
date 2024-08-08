{
	description = "NixOS CONFIG!!!";

	outputs = {
		self,
		nixpkgs,
		home-manager,
		...
	} @ inputs: let
		inherit (self) outputs;
		# Supported systems for your flake packages, shell, etc.
		systems = [
			"aarch64-linux"
			"i686-linux"
			"x86_64-linux"
			"aarch64-darwin"
			"x86_64-darwin"
		];
		# This is a function that generates an attribute by calling a function you
		# pass to it, with each system as an argument
		forAllSystems = nixpkgs.lib.genAttrs systems;
	in rec {
		# Your custom packages
		# Accessible through 'nix build', 'nix shell', etc
		packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
		# Formatter for your nix files, available through 'nix fmt'
		# Other options beside 'alejandra' include 'nixpkgs-fmt'
		# formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

		# Your custom packages and modifications, exported as overlays
		overlays = import ./overlays {inherit inputs;};
		# Reusable nixos modules you might want to export
		# These are usually stuff you would upstream into nixpkgs
		nixosModules = import ./modules/nixos;
		# Reusable home-manager modules you might want to export
		# These are usually stuff you would upstream into home-manager
		homeManagerModules = import ./modules/home-manager;

		# NixOS configuration entrypoint
		# Available through 'nixos-rebuild --flake .#your-hostname'
		nixosConfigurations = {
			toaster = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs outputs; system = "x86_64-linux";};
				modules = [
					# > Our main nixos configuration file <
					# ./nixos/configuration.nix
					inputs.wallpapers.nixosModules.default
					./hosts/toaster
				];
			};
		};

		# Standalone home-manager configuration entrypoint
		# Available through 'home-manager --flake .#hamburgir'

		homeConfigurations = {
			hamburgir = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
				extraSpecialArgs = {inherit inputs outputs;};
				modules = [
					inputs.wallpapers.homeManagerModules.default
					inputs.stylix.homeManagerModules.stylix

					# inputs.ags.homeManagerModules.default

					inputs.nixvim.homeManagerModules.nixvim

					# inputs.webcord.homeManagerModules.default

					./users/hamburgir
				] ++ (builtins.attrValues outputs.homeManagerModules);
			};
		};
		# homeConfigurations = {
		# 	hamburgir = ;
		# };
	};

	inputs = {
		# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

		# Home manager
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";


		stylix.url = "github:danth/stylix";
		catppuccin-sddm = {
			url = "https://github.com/catppuccin/sddm/releases/download/v1.0.0/catppuccin-mocha.zip";
			flake = false;
		};
		grub2-themes.url = "github:vinceliuice/grub2-themes";
		wallpapers = {
			url = "github:h4m6urg1r/wallpapers";
			inputs.nixpkgs.follows = "nixpkgs";
		};


		superfile = {
			url = "github:MHNightCat/superfile";
		};


		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};


		# webcord.url = "github:fufexan/webcord-flake";


		# ags.url = "github:Aylur/ags";
		fabricConfig = {
			# url = "github:h4m6urg1r/fabricConfig.git";
			url = "git+file:///home/hamburgir/repo/fabricConfig";
		};


		nixos-hardware.url = "github:NixOS/nixos-hardware/master";


		powerlevel10k = {
			url = "github:romkatv/powerlevel10k";
			flake = false;
		};
	};
}
