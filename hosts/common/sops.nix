{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {...}: {
        sops = {
          # System decrypt key for activation (root FS). Edit host secrets as user
          # with ~/.config/sops/age/keys.txt (SSH-derived); both are recipients for hosts/.
          age = {
            keyFile = "/var/lib/sops-nix/key.txt";
            sshKeyPaths = [];
          };
          gnupg.sshKeyPaths = [];
        };
      }
    )
  ];
}
