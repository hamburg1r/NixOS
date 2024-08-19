{
	pkgs,
	...
}: {
	boot.initrd.kernelModules = [ "amdgpu" ];
	services.xserver.videoDrivers = [ "amdgpu" ];

	hardware.graphics = {
		enable = true;
		# For 32 bit applications
		# driSupport32Bit = true;

		extraPackages = with pkgs; [
			amdvlk
		];
		# For 32 bit applications 
		# Only available on unstable
		extraPackages32 = with pkgs; [
			driversi686Linux.amdvlk
		];
	};

}
