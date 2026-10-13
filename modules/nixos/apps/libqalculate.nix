{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.libqalculate;
      in {
        options.desktop.apps.libqalculate = {
          enable = lib.mkEnableOption "libqalculate, a calculator library";
          package = lib.mkPackageOption pkgs "libqalculate" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
