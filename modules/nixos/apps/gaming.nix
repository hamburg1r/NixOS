{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        gamescope = config.desktop.apps.gamescope;
        steam = config.desktop.apps.steam;
      in {
        imports = [
          {
            options.desktop.apps.gamescope = {
              enable = lib.mkEnableOption "gamescope, a micro-compositor for games";
              package = lib.mkPackageOption pkgs "gamescope" {};
            };

            config = lib.mkIf gamescope.enable {
              programs.gamescope = {
                enable = true;
                package = gamescope.package;
                capSysNice = true;
              };
            };
          }
          {
            options.desktop.apps.steam = {
              enable = lib.mkEnableOption "steam";
              package = lib.mkPackageOption pkgs "steam" {};
            };

            config = lib.mkIf steam.enable {
              programs.steam = {
                enable = true;
                package = steam.package;
                remotePlay.openFirewall = true;
                dedicatedServer.openFirewall = true;
                localNetworkGameTransfers.openFirewall = true;
              };
            };
          }
        ];
      }
    )
  ];
}
