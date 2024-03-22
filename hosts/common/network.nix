{
	lib,
	...
}: {
	networking = {
		hostName = "toaster";

		firewall = {
			enable = lib.mkDefault true;
			allowPing = lib.mkDefault false;
		};

		networkmanager.enable = lib.mkDefault true;

		# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
		# (the default) this is the recommended approach. When using systemd-networkd it's
		# still possible to use this option, but it's recommended to use it in conjunction
		# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
		useDHCP = lib.mkDefault true;
		# interfaces.wlp1s0.useDHCP = lib.mkDefault true;
	};

	services.openssh = {
		enable = lib.mkDefault true;
	};
}
