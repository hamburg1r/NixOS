{
	config,
	...
}: {
	services.blueman.enable = config.hardware.bluetooth.enable;
	hardware.bluetooth = {
		enable = true;
		powerOnBoot = false;
	};
}
