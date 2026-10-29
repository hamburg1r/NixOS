{...}: {
  config.dendritic.nixos.toaster = [
    (
      {config, ...}: let
        hostKey = "hosts/toaster/ssh/ssh_host_ed25519_key";
      in {
        sops.secrets.${hostKey} = {
          sopsFile = ../../secrets/hosts/toaster/ssh/ssh_host_ed25519_key;
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
