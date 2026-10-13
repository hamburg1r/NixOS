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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable?shallow=1";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable?shallow=1";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05?shallow=1";

    # Flake plumbing
    flake-parts.url = "github:hercules-ci/flake-parts?shallow=1";
    import-tree.url = "github:vic/import-tree?shallow=1";

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
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:hamburg1r/wallpapers?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ignis-config = {
      url = "github:hamburg1r/ignis-config?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake/very-refactor?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
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
      url = "git+file:///home/hamburgir/repo/scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    homesync = {
      url = "github:hamburg1r/homesync?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master?shallow=1";
  };
}
