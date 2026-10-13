{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.lf;
      in {
        options.desktop.apps.lf = {
          enable = lib.mkEnableOption "lf, a terminal file manager";
          package = lib.mkPackageOption pkgs "lf" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
