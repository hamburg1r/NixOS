{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.ristretto;
      in {
        options.desktop.apps.ristretto = {
          enable = lib.mkEnableOption "ristretto, an image viewer";
          package = lib.mkPackageOption pkgs "ristretto" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
