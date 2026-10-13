{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.noto-fonts;
      in {
        options.desktop.apps.noto-fonts = {
          enable = lib.mkEnableOption "the Noto font family";
          package = lib.mkPackageOption pkgs "noto-fonts" {};
        };

        config = lib.mkIf cfg.enable {
          fonts.packages = [cfg.package];
        };
      }
    )
  ];
}
