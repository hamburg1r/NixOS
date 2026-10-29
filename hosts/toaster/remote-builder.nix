# Offload builds to microwave. The matching SSH authorization lives in
# hosts/microwave/remote-builder.nix.
{...}: {
  config.dendritic.nixos.toaster = [
    (
      {
        config,
        ...
      }: let
        sshKey = "hosts/toaster/ssh/ssh_host_ed25519_key";
      in {
        nix = {
          distributedBuilds = true;

          buildMachines = [
            {
              # Resolved through Tailscale MagicDNS. Use the FQDN or IP if
              # MagicDNS is unavailable on toaster.
              hostName = "microwave";
              protocol = "ssh-ng";
              sshUser = "root";
              sshKey = config.sops.secrets.${sshKey}.path;
              system = "x86_64-linux";
              maxJobs = 16;
              speedFactor = 4;
              supportedFeatures = [
                "nixos-test"
                "benchmark"
                "big-parallel"
                "kvm"
              ];
              # base64 -w0 /etc/ssh/ssh_host_ed25519_key.pub on microwave
              publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUhnaG92MjRnVFczQy9FeDVXczRuTlRUcytpSTlxTXArSjFxT2ZyVyttZnYgcm9vdEB0b2FzdGVyCg==";
            }
          ];

          # Let microwave fetch dependencies from the binary caches instead of
          # copying every input closure from toaster.
          settings.builders-use-substitutes = true;
        };
      }
    )
  ];
}
