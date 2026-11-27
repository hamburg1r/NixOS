{
  description = "NixOS CONFIG!!! (dendritic)";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        (inputs.import-tree ./parts)
        (inputs.import-tree ./hosts)
        # `wezterm/ui.nix` and `miscellaneous.nix` are Lua string
        # fragments, not modules. Keep them out of the tree.
        (inputs.import-tree.filterNot (p:
          inputs.nixpkgs.lib.hasInfix "wezterm/ui.nix" (toString p)
          || inputs.nixpkgs.lib.hasInfix "wezterm/miscellaneous.nix" (toString p))
        ./users)
        (inputs.import-tree ./modules)
      ];
    };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Flake plumbing
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
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
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:hamburg1r/wallpapers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ignis-config = {
      url = "github:hamburg1r/ignis-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake/very-refactor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:duxlabs-dev/dux-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvimConfig = {
      url = "github:hamburg1r/nixvimConfig";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    scripts = {
      url = "github:hamburg1r/scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homesync = {
      url = "github:hamburg1r/homesync";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rea = {
      url = "https://registry.npmjs.org/rea-agents/-/rea-agents-6.10.1.tgz";
      flake = false;
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
}
