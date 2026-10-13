{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.brightnessctl;
      in {
        options.desktop.apps.brightnessctl = {
          enable = lib.mkEnableOption "brightnessctl, a backlight control tool";
          package = lib.mkPackageOption pkgs "brightnessctl" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
