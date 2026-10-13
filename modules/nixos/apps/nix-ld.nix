{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.nix-ld;
      in {
        options.desktop.apps.nix-ld = {
          enable = lib.mkEnableOption "nix-ld, for running unpatched dynamic binaries";
          package = lib.mkPackageOption pkgs "nix-ld" {};
        };

        config = lib.mkIf cfg.enable {
          programs.nix-ld = {
            enable = true;
            package = cfg.package;
            # libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
          };
        };
      }
    )
  ];
}
