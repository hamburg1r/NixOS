{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.noto-fonts-color-emoji;
      in {
        options.desktop.apps.noto-fonts-color-emoji = {
          enable = lib.mkEnableOption "the Noto Color Emoji font";
          package = lib.mkPackageOption pkgs "noto-fonts-color-emoji" {};
        };

        config = lib.mkIf cfg.enable {
          fonts.packages = [cfg.package];
        };
      }
    )
  ];
}
