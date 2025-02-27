{
	inputs,
	config,
	pkgs,
	lib,
	outputs,
	system,
	...
}: {
	imports = [
		./hardware

		./audio.nix
		./boot
		./bluetooth.nix
		./fonts.nix
		./network.nix

		./packages
	];

	nixpkgs = {
		overlays = [
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.stable-packages
			outputs.overlays.unstable-packages

			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#   hi = final.hello.overrideAttrs (oldAttrs: {
			#     patches = [ ./change-hello-to-hi.patch ];
			#   });
			# })
		];
		config = {
			allowUnfree = lib.mkDefault true;
		};
	};

	nix = {
		# This will add each flake input as a registry
		# To make nix3 commands consistent with your flake
		registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

		# This will additionally add your inputs to the system's legacy channels
		# Making legacy nix commands consistent as well, awesome!
		nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

		settings = {
			accept-flake-config = true;
			allowed-users = [ "root" "@wheel" ];
			auto-optimise-store = lib.mkDefault true;
			# Enable flakes and new 'nix' command
			experimental-features = "nix-command flakes";
			min-free = lib.mkDefault 1073741824;
			max-free = lib.mkDefault 1073741824;

			substituters = [
				"https://hamburgir.cachix.org"
				"https://cache.nixos.org/"
			];
			trusted-public-keys = [
				"hamburgir.cachix.org-1:KMZ+IBiEsG1s+wrw3+Dh14ZC0aGZucZivjbN7qMZK7Q="
			];
			trusted-users = [
				"root"
				"hamburgir"
			];
		};

		# gc = {
		# 	automatic = lib.mkDefault true;
		# 	dates = lib.mkDefault "weekly";
		# 	options = lib.mkDefault "--delete-older-than 3";
		# };
	};

	environment.systemPackages = with pkgs; [
		nix-output-monitor
		nvd
	];
	programs = {
		nh = {
			enable = true;
			clean = {
				enable = true;
				extraArgs = "--keep-since 3d --keep 5";
				dates = "daily";
				# TODO: !!important!! change
			};
			# FIXME: change if not this path
			flake = "/home/hamburgir/repo/NixOS";
		};

		mtr.enable = lib.mkDefault true;

		dconf.enable = lib.mkDefault true;
	};

	nixpkgs.hostPlatform = lib.mkDefault system;
	system.stateVersion = lib.mkDefault "24.05";
}
