{
	lib,
	...
}: {
	boot = {
		tmp.cleanOnBoot = lib.mkDefault true;
		supportedFilesystems = lib.mkDefault [ "ext4" "fat32" "vfat" ];
	};

	fileSystems."/" = lib.mkDefault {
		device = "/dev/disk/by-label/root";
		fsType = "ext4";
	};

	fileSystems."/home" = lib.mkDefault {
		device = "/dev/disk/by-label/home";
		fsType = "ext4";
	};

	fileSystems."/boot/efi" = lib.mkDefault {
		device = "/dev/disk/by-label/EFI";
		fsType = "vfat";
	};

	swapDevices = lib.mkDefault [{
		device = "/dev/disk/by-label/swap";
		priority = 60;
		size = null;
	}];
}
