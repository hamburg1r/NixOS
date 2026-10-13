{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.ydotool;
      in {
        options.desktop.apps.ydotool = {
          enable = lib.mkEnableOption "ydotool, a generic input automation tool";
          package = lib.mkPackageOption pkgs "ydotool" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
