{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.distrobox;
      in {
        options.desktop.apps.distrobox = {
          enable = lib.mkEnableOption "distrobox, for containerised distros";
          package = lib.mkPackageOption pkgs "distrobox" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
