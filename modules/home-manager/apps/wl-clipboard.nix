{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.wl-clipboard;
      in {
        options.desktop.apps.wl-clipboard = {
          enable = lib.mkEnableOption "wl-clipboard, Wayland clipboard utilities";
          package = lib.mkPackageOption pkgs "wl-clipboard" {};
        };

        config = lib.mkIf cfg.enable {
          home.packages = [cfg.package];
        };
      }
    )
  ];
}
