{
	lib,
	pkgs,
	config,
	...
}: {
	boot.loader = {
		grub = {
			enable = lib.mkDefault true;
			efiSupport = lib.mkDefault true;
			device = lib.mkDefault "nodev";
			useOSProber = lib.mkDefault true;
			copyKernels = lib.mkDefault true;
			# fontSize = lib.mkDefault 16;
			theme = lib.mkDefault pkgs.nixos-grub2-theme;
		};
	};
}
