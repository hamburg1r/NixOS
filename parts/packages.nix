{
  inputs,
  config,
  ...
}: let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  flake.overlays = config.dendritic.overlays;

  flake.packages.${system} =
    (import ../pkgs {inherit inputs pkgs;})
    // {
      iso = config.flake.nixosConfigurations.iso.config.system.build.isoImage;
    };

  flake.devShells.${system} = import ../shell.nix {inherit pkgs;};
}
