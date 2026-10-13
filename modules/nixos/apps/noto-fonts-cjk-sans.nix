{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.noto-fonts-cjk-sans;
      in {
        options.desktop.apps.noto-fonts-cjk-sans = {
          enable = lib.mkEnableOption "the Noto CJK sans font";
          package = lib.mkPackageOption pkgs "noto-fonts-cjk-sans" {};
        };

        config = lib.mkIf cfg.enable {
          fonts.packages = [cfg.package];
        };
      }
    )
  ];
}
