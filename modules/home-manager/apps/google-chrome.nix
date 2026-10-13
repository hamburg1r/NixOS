{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.google-chrome;
      in {
        options.desktop.apps.google-chrome = {
          enable = lib.mkEnableOption "google-chrome";
          package = lib.mkPackageOption pkgs "google-chrome" {};
        };

        config = lib.mkIf cfg.enable {
          home.packages = [cfg.package];
        };
      }
    )
  ];
}
