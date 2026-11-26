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

  flake.apps.${system}.build-iso = let
    buildIso = pkgs.writeShellApplication {
      name = "build-iso";
      runtimeInputs = with pkgs; [age sops nix coreutils];
      text = builtins.readFile ../iso/build.sh;
    };
  in {
    type = "app";
    program = "${buildIso}/bin/build-iso";
  };

  flake.devShells.${system} = import ../shell.nix {inherit pkgs;};
}
