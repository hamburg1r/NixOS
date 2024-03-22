{
	config,
	pkgs,
	...
}: {
	boot = {
		initrd = {
			availableKernelModules = [
				"xhci_pci"
				"ahci"
				"usb_storage"
				"sd_mod"
				"rtsx_usb_sdmmc"
			];
			kernelModules = [ ];
		};
		kernelModules = [ "kvm-amd" "8812au" ];
		kernelParams = [
			"quiet"
			"udev.log_level=3"
		];
		kernelPackages = pkgs.linuxPackages_latest;
		consoleLogLevel = 3;
		initrd.verbose = true;
	};
}
