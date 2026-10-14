{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.microwave = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      outputs = {overlays = config.dendritic.overlays;};
      system = "x86_64-linux";
    };
    modules =
      [
        inputs.wallpapers.nixosModules.default
        inputs.ignis-config.nixosModules.default
        inputs.dms.nixosModules.dank-material-shell
        inputs.homesync.nixosModules.homesync
        inputs.sops-nix.nixosModules.sops
        inputs.lanzaboote.nixosModules.lanzaboote
        # no wifi / bluetooth
      ]
      ++ config.dendritic.nixos.common
      ++ config.dendritic.nixos.microwave;
  };
}
