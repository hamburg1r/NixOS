{
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      outputs = {overlays = config.dendritic.overlays;};
      system = "x86_64-linux";
    };
    modules = [../iso];
  };
}
