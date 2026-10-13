{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.liberation-ttf;
      in {
        options.desktop.apps.liberation-ttf = {
          enable = lib.mkEnableOption "the Liberation font family";
          package = lib.mkPackageOption pkgs "liberation_ttf" {};
        };

        config = lib.mkIf cfg.enable {
          fonts.packages = [cfg.package];
        };
      }
    )
  ];
}
