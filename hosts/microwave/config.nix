# General host config and high-level feature toggles for microwave.
#
# `dendritic.features.microwave` is threaded into the NixOS evaluation as the
# `features` special argument and consulted by the app baselines
# (e.g. hosts/common/apps.nix) to enable/disable whole feature groups.
{...}: {
  config.dendritic.features.microwave = {
    gaming = true;
    development = true;
  };

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

        users.users.hamburgir.openssh.authorizedKeys.keys = [
        ];
      }
    )
  ];
}
