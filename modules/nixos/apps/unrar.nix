{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.unrar;
      in {
        options.desktop.apps.unrar = {
          enable = lib.mkEnableOption "unrar";
          package = lib.mkPackageOption pkgs "unrar" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
