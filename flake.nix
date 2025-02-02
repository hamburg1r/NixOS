{
	description = "NixOS CONFIG!!!";

	outputs = {
		self,
		nixpkgs,
		home-manager,
		nixpkgs-stable,
		nix-on-droid,
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

		overlays = import ./overlays {inherit inputs;};

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
					inputs.stylix.homeManagerModules.stylix

					# inputs.ags.homeManagerModules.default

					inputs.nixvim.homeManagerModules.nixvim
					inputs.nvf.homeManagerModules.default

					# inputs.webcord.homeManagerModules.default

					./users/hamburgir
				] ++ (builtins.attrValues outputs.homeManagerModules);
			};
		};

		nixOnDroidConfigurations = {
			default = nix-on-droid.lib.nixOnDroidConfiguration {
				pkgs = import nixpkgs-stable { system = "aarch64-linux"; };
				modules = [ ./android/default ];
			};
		};
	};

	inputs = {
		# Nixpkgs
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

		# Home manager
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		# Android
		# nix-on-droid = {
		# 	url = "github:nix-community/nix-on-droid/release-24.05";
		# 	inputs.nixpkgs.follows = "nixpkgs-stable";
		# };


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
			# inputs.nixpkgs.follows = "nixpkgs";
		};
		nvf = {
			url = "github:notashelf/nvf";
			inputs.nixpkgs.follows = "nixpkgs-unstable";
		};

		live-server = {
			url = "github:barrett-ruth/live-server.nvim";
			flake = false;
		};
		journal-nvim = {
			url = "github:jakobkhansen/journal.nvim";
			flake = false;
		};
		autosave-nvim = {
			url = "github:0x00-ketsu/autosave.nvim";
			flake = false;
		};


		# webcord.url = "github:fufexan/webcord-flake";


		# ags.url = "github:Aylur/ags";
		# fabricConfig = {
			# url = "github:h4m6urg1r/fabricConfig.git";
			# url = "git+file:///home/hamburgir/repo/fabricConfig";
		# };


		nixos-hardware.url = "github:NixOS/nixos-hardware/master";


		powerlevel10k = {
			url = "github:romkatv/powerlevel10k";
			flake = false;
		};
	};
}
