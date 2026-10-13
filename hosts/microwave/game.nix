{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {pkgs, ...}: {
        programs = {
          nix-ld = {
            # libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
          };
          gamescope = {
            enable = true;
            capSysNice = true;
          };
          steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
          };
        };
        environment = {
          systemPackages = [
            pkgs.mangohud
          ];
        };
      }
    )
  ];
}
