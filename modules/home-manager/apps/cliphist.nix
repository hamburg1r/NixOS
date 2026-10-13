{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.cliphist;
      in {
        options.desktop.apps.cliphist = {
          enable = lib.mkEnableOption "cliphist, a Wayland clipboard history";
          package = lib.mkPackageOption pkgs "cliphist" {};
        };

        config = lib.mkIf cfg.enable {
          home.packages = [cfg.package];
        };
      }
    )
  ];
}
