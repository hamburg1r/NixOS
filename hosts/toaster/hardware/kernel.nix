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
		kernelModules = [
			"kvm-amd"
			"8812au"
			"v4l2loopback"
		];
		extraModprobeConfig = lib.mkIf (builtins.elem "v4l2loopback" config.boot.kernelModules) ''
			options v4l2loopback exclusive_caps=1 card_label="VCam"
		'';
		kernelParams = lib.mkIf (!config.custom.plymouth.enable) [
			"quiet"
			"udev.log_level=3"
		];
		kernelPackages = pkgs.linuxPackages_latest;
		consoleLogLevel = lib.mkIf (!config.custom.plymouth.enable) 3;
		initrd.verbose = lib.mkIf (!config.custom.plymouth.enable) true;
	};
}
