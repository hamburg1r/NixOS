{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.ristretto;
      in {
        options.desktop.apps.ristretto = {
          enable = lib.mkEnableOption "ristretto, an image viewer";
          package = lib.mkPackageOption pkgs "ristretto" {};
        };

        config = lib.mkIf cfg.enable {
          home.packages = [cfg.package];
        };
      }
    )
  ];
}
