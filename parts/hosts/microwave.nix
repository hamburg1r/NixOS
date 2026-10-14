{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.microwave = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      outputs = {
        overlays = config.dendritic.overlays;
        lib = config.dendritic.lib;
      };
      system = "x86_64-linux";
      features = config.dendritic.features.microwave or {};
    };
    modules =
      [
        inputs.wallpapers.nixosModules.default
        inputs.ignis-config.nixosModules.default
        inputs.dms.nixosModules.dank-material-shell
        inputs.homesync.nixosModules.homesync
        inputs.sops-nix.nixosModules.sops
        # no wifi / bluetooth, and no lanzaboote boot (limine instead)
      ]
      ++ config.dendritic.nixos.common
      ++ config.dendritic.nixos.microwave;
  };
}
