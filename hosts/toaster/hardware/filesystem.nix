{...}: {
  config.dendritic.nixos.toaster = [
    (
      {...}: {
        boot = {
          tmp = {
            cleanOnBoot = true;
            useTmpfs = true;
            # tmpfsSize = "30%";
          };
          supportedFilesystems = ["ext4" "fat32" "ntfs" "vfat"];
        };

        # Boots from the HDD (SATA, ext4); the NVMe SSD moves to microwave.
        fileSystems."/" = {
          device = "/dev/disk/by-label/NixOs";
          fsType = "ext4";
        };

        fileSystems."/home" = {
          device = "/dev/disk/by-label/Home";
          fsType = "ext4";
        };

        fileSystems."/boot/efi" = {
          device = "/dev/disk/by-label/OLDEFI";
          fsType = "vfat";
        };

        fileSystems."/mnt/games" = {
          device = "/dev/disk/by-label/games";
          fsType = "ext4";
        };

        fileSystems."/mnt/other" = {
          device = "/dev/disk/by-label/other";
          fsType = "ext4";
        };

        swapDevices = [
          {
            device = "/dev/disk/by-label/Swap";
            priority = 60;
            size = null;
          }
        ];
      }
    )
  ];
}
