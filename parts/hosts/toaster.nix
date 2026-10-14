{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.toaster = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      outputs = {
        overlays = config.dendritic.overlays;
        lib = config.dendritic.lib;
      };
      system = "x86_64-linux";
      features = config.dendritic.features.toaster or {};
    };
    modules =
      [
        inputs.wallpapers.nixosModules.default
        inputs.ignis-config.nixosModules.default
        inputs.dms.nixosModules.dank-material-shell
        inputs.lanzaboote.nixosModules.lanzaboote
        inputs.sops-nix.nixosModules.sops
      ]
      ++ config.dendritic.nixos.common
      ++ config.dendritic.nixos.toaster;
  };
}
