{
	inputs,
	...
}: {
	imports = [
		inputs.nixos-hardware.nixosModules.common-cpu-amd
	];
	hardware.enableRedistributableFirmware = true;
	hardware.enableAllFirmware = true;
}
