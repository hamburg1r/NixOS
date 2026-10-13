{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.devenv;
      in {
        options.desktop.apps.devenv = {
          enable = lib.mkEnableOption "devenv, for declarative developer environments";
          package = lib.mkPackageOption pkgs "devenv" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
