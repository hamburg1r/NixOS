{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.easyeffects;
      in {
        options.desktop.apps.easyeffects = {
          enable = lib.mkEnableOption "easyeffects, an audio effects processor";
          package = lib.mkPackageOption pkgs ["stable" "easyeffects"] {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
