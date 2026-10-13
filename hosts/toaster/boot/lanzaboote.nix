{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {lib, ...}: {
        # Lanzaboote owns the ESP via boot.loader.external.
        boot.loader.systemd-boot.enable = lib.mkForce false;
        boot.loader.grub.enable = lib.mkForce false;

        boot.lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
          # ESP is 500M; each kernel+initrd pair is ~100M.
          configurationLimit = 4;
        };
      }
    )
  ];
}
