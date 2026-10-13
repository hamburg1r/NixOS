{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.sbctl;
      in {
        options.desktop.apps.sbctl = {
          enable = lib.mkEnableOption "sbctl, for Secure Boot key management";
          package = lib.mkPackageOption pkgs "sbctl" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
