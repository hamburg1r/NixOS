{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.usbutils;
      in {
        options.desktop.apps.usbutils = {
          enable = lib.mkEnableOption "usbutils, for lsusb";
          package = lib.mkPackageOption pkgs "usbutils" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
