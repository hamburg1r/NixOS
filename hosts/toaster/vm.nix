{
	...
}: {
	virtualisation = {
		# waydroid.enable = true;
		# lxd.enable = true;
		# docker = {
		# 	enable = false;
		# 	rootless = {
		# 		enable = true;
		# 		setSocketVariable = true;
		# 	};
		# };
		podman = {
			enable = true;
			# Create a `docker` alias for podman, to use it as a drop-in replacement
			dockerCompat = true;

			# Required for containers under podman-compose to be able to talk to each other.
			# defaultNetwork.settings.dnsname.enable = true;
			# For Nixos version > 22.11
			defaultNetwork.settings = {
				dns_enabled = true;
			};
		};
		# libvirtd.enable=true;
	};
	programs.virt-manager.enable = true;
}
