{...}: {
  config.dendritic.nixos.microwave = [
    (
      {...}: {
        networking = {
          hostName = "microwave";

          firewall = {
            enable = false;
            allowPing = true;
          };

          networkmanager = {
            # machine has no wifi; wired only
            wifi.powersave = false;
          };
        };

        services.tailscale.enable = true;
      }
    )
  ];
}
