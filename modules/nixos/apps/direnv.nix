{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.direnv;
      in {
        options.desktop.apps.direnv = {
          enable = lib.mkEnableOption "direnv, for per-directory environments";
          package = lib.mkPackageOption pkgs "direnv" {};
        };

        config = lib.mkIf cfg.enable {
          programs.direnv = {
            enable = true;
            package = cfg.package;
          };
        };
      }
    )
  ];
}
