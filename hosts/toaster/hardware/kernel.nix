{
	config,
	pkgs,
	lib,
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
		kernelParams = lib.mkIf (!config.custom.plymouth.enable) [
			"quiet"
			"udev.log_level=3"
		];
		kernelPackages = pkgs.linuxPackages_latest;
		consoleLogLevel = lib.mkIf (!config.custom.plymouth.enable) 3;
		initrd.verbose = lib.mkIf (!config.custom.plymouth.enable) true;
	};
}
