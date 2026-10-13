{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.git;
      in {
        options.desktop.apps.git = {
          enable = lib.mkEnableOption "git";
          package = lib.mkPackageOption pkgs "git" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
