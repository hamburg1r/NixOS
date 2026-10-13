{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.gamescope;
      in {
        options.desktop.apps.gamescope = {
          enable = lib.mkEnableOption "gamescope, a micro-compositor for games";
          package = lib.mkPackageOption pkgs "gamescope" {};
        };

        config = lib.mkIf cfg.enable {
          programs.gamescope = {
            enable = true;
            package = cfg.package;
            capSysNice = true;
          };
        };
      }
    )
  ];
}
