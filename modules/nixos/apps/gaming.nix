{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "gamescope" {
            name = "gamescope";
            description = "gamescope, a micro-compositor for games";
            settings.capSysNice = true;
          })
          (outputs.lib.mkProgram pkgs "steam" {
            name = "steam";
            description = "steam";
            settings = {
              remotePlay.openFirewall = true;
              dedicatedServer.openFirewall = true;
              localNetworkGameTransfers.openFirewall = true;
            };
          })
        ];
      }
    )
  ];
}
