{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.lz4;
      in {
        options.desktop.apps.lz4 = {
          enable = lib.mkEnableOption "lz4";
          package = lib.mkPackageOption pkgs "lz4" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
