# Accept remote builds from toaster. The client side is configured in
# hosts/toaster/remote-builder.nix.
{...}: {
  config.dendritic.nixos.microwave = [
    (
      {...}: {
        # toaster's Nix daemon logs in as root with this dedicated key.
        # root is already in nix.settings.trusted-users (hosts/common/default.nix).
        users.users.root.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkPzrQOHodTezzDcIIr50OWoGH4rGRx+PGwDn6xjpMH root@toaster remote-builder"
        ];
      }
    )
  ];
}
