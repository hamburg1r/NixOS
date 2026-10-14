{...}: {
  config.dendritic.nixos.microwave = [
    (
      {lib, ...}: {
        # Fast, supports Secure Boot out of the box (unlike GRUB + shim).
        boot.loader = {
          # Limine module also mkDefault'd grub off; our mkForce overrides common's mkDefault.
          grub.enable = lib.mkForce false;
          systemd-boot.enable = lib.mkForce false;

          limine = {
            enable = true;

            # Secure Boot using sbctl-managed keys. First-boot steps:
            #   nix run nixpkgs#sbctl create-keys
            #   nix run nixpkgs#sbctl enroll-keys -m -f   (in firmware "setup mode")
            # then rebuild with this option enabled, and finally turn Secure Boot on in the BIOS.
            secureBoot.enable = true;
            # Secure boot makes the editor unusable anyway; also prevents init=/bin/sh escapes.
            enableEditor = false;
            maxGenerations = 20;

            # Windows chainload (dual boot). bootmgfw.efi lives on the shared ESP.
            extraEntries = ''
              :Windows
                  protocol: chainload
                  image_path: boot()/EFI/Microsoft/Boot/bootmgfw.efi
            '';
          };
        };
      }
    )
  ];
}
