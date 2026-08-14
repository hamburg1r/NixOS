{
	pkgs,
	lib,
	...
}: {
	environment.systemPackages = [ pkgs.sbctl ];

	# Lanzaboote owns the ESP via boot.loader.external.
	boot.loader.systemd-boot.enable = lib.mkForce false;
	boot.loader.grub.enable = lib.mkForce false;

	boot.lanzaboote = {
		enable = true;
		pkiBundle = "/var/lib/sbctl";
	};
}
