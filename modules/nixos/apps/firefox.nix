{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.firefox;
      in {
        options.desktop.apps.firefox = {
          enable = lib.mkEnableOption "firefox";
          package = lib.mkPackageOption pkgs "firefox" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
