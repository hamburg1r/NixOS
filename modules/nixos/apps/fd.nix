{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.fd;
      in {
        options.desktop.apps.fd = {
          enable = lib.mkEnableOption "fd, a find alternative";
          package = lib.mkPackageOption pkgs "fd" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
