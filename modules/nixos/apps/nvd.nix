{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.nvd;
      in {
        options.desktop.apps.nvd = {
          enable = lib.mkEnableOption "nvd, the Nix version diff tool";
          package = lib.mkPackageOption pkgs "nvd" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
