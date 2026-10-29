{...}: {
  config.dendritic.nixos.microwave = [
    (
      {config, ...}: let
        hostKey = "hosts/microwave/ssh/ssh_host_ed25519_key";
      in {
        sops.secrets.${hostKey} = {
          sopsFile = ../../secrets/hosts/microwave/ssh/ssh_host_ed25519_key;
          format = "binary";
          owner = "root";
          group = "root";
          mode = "0600";
          path = "/etc/ssh/ssh_host_ed25519_key";
        };
      }
    )
  ];
}
