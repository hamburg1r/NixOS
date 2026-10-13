{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.nix-output-monitor;
      in {
        options.desktop.apps.nix-output-monitor = {
          enable = lib.mkEnableOption "nix-output-monitor";
          package = lib.mkPackageOption pkgs "nix-output-monitor" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
