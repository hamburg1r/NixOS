{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.steam;
      in {
        options.desktop.apps.steam = {
          enable = lib.mkEnableOption "steam";
          package = lib.mkPackageOption pkgs "steam" {};
        };

        config = lib.mkIf cfg.enable {
          programs.steam = {
            enable = true;
            package = cfg.package;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
          };
        };
      }
    )
  ];
}
