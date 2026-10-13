{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.zenity;
      in {
        options.desktop.apps.zenity = {
          enable = lib.mkEnableOption "zenity, for GTK dialogs";
          package = lib.mkPackageOption pkgs "zenity" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
