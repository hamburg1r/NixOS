{
	...
}: {
	networking = {
		hostName = "toaster";

		firewall = {
			# enable = false;
			allowPing = true;
		};
	};

	services.tailscale.enable = true;

	# services.openssh.ports = [ 22 8022 ];
}
