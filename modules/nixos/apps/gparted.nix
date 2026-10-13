{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.gparted;
      in {
        options.desktop.apps.gparted = {
          enable = lib.mkEnableOption "GParted, a partition editor";
          package = lib.mkPackageOption pkgs "gparted" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
