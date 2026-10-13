{
  inputs,
  config,
  ...
}: {
  flake.homeConfigurations.hamburgir = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = {
      inherit inputs;
      outputs = {overlays = config.dendritic.overlays;};
    };
    modules =
      [
        inputs.wallpapers.homeManagerModules.default
        inputs.ignis-config.homeManagerModules.default
        inputs.niri.homeModules.niri
        inputs.sops-nix.homeManagerModules.sops
      ]
      ++ config.dendritic.home.common
      ++ config.dendritic.home.hamburgir;
  };
}
