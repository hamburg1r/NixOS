{
	lib,
	...
}: {
	boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;
	boot.loader.efi.efiSysMountPoint = lib.mkDefault "/boot/efi";
}
