{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.nemo;
      in {
        options.desktop.apps.nemo = {
          enable = lib.mkEnableOption "nemo, the Cinnamon file manager";
          package = lib.mkPackageOption pkgs "nemo" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
