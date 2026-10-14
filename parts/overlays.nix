{inputs, ...}: {
  config.dendritic.overlays = import ../overlays {
    inherit inputs;
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  };
}
