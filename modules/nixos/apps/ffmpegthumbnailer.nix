{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.ffmpegthumbnailer;
      in {
        options.desktop.apps.ffmpegthumbnailer = {
          enable = lib.mkEnableOption "ffmpegthumbnailer, for video thumbnails";
          package = lib.mkPackageOption pkgs "ffmpegthumbnailer" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
