{
	lib,
	...
}: {
	boot = {
		tmp.cleanOnBoot = lib.mkDefault true;
		supportedFilesystems = lib.mkDefault [ "ext4" "fat32" "vfat" ];
	};

	swapDevices = lib.mkDefault [{
		device = "/dev/disk/by-label/swap";
		priority = 60;
		size = null;
	}];
}
