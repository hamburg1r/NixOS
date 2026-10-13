{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.mtr;
      in {
        options.desktop.apps.mtr = {
          enable = lib.mkEnableOption "mtr, a network diagnostic tool";
          package = lib.mkPackageOption pkgs "mtr" {};
        };

        config = lib.mkIf cfg.enable {
          programs.mtr = {
            enable = lib.mkDefault true;
            package = cfg.package;
          };
        };
      }
    )
  ];
}
