{
	config,
	lib,
	...
}: {
	options = {
		automount-tools.enable = lib.mkOption {
			default = true;
		};
	};
	config = lib.mkIf config.automount-tools.enable {
		services.gvfs.enable = true;
		services.udisks2.enable = true;
		services.devmon.enable = true;
	};
}
