{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.libnotify;
      in {
        options.desktop.apps.libnotify = {
          enable = lib.mkEnableOption "libnotify, for desktop notifications";
          package = lib.mkPackageOption pkgs "libnotify" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
