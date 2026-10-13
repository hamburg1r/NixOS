{
	pkgs,
	...
}: {
	environment.systemPackages = with pkgs; [
		distrobox
		usbutils
		libqalculate
	];
}
