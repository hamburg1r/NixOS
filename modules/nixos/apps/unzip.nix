{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.unzip;
      in {
        options.desktop.apps.unzip = {
          enable = lib.mkEnableOption "unzip";
          package = lib.mkPackageOption pkgs "unzip" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
