{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.trash-cli;
      in {
        options.desktop.apps.trash-cli = {
          enable = lib.mkEnableOption "trash-cli, for a freedesktop trash can";
          package = lib.mkPackageOption pkgs "trash-cli" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
