{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.pear-desktop;
      in {
        options.desktop.apps.pear-desktop = {
          enable = lib.mkEnableOption "pear-desktop, a YouTube Music client";
          package = lib.mkPackageOption pkgs "pear-desktop" {};
        };

        config = lib.mkIf cfg.enable {
          home.packages = [cfg.package];
        };
      }
    )
  ];
}
