{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.mpv;
      in {
        options.desktop.apps.mpv = {
          enable = lib.mkEnableOption "mpv, a media player";
          package = lib.mkPackageOption pkgs "mpv" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
