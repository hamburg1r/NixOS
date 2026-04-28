{
	...
}: {
	networking = {
		hostName = "toaster";

		firewall = {
			# enable = false;
			allowPing = true;
		};

		networkmanager = {
			wifi.powersave = false;
			# macAddress = "random";
			# logLevel = "DEBUG";
		};
	};

	services.tailscale.enable = true;

	# services.openssh.ports = [ 22 8022 ];
}
