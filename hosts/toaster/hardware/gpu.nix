{
	pkgs,
	...
}: {
	boot.initrd.kernelModules = [ "amdgpu" ];
	services.xserver.videoDrivers = [ "amdgpu" ];

	hardware.opengl.enable = true;
	# hardware.opengl.driSupport = true;
	# For 32 bit applications
	hardware.opengl.driSupport32Bit = true;

	hardware.opengl.extraPackages = with pkgs; [
		amdvlk
	];
	# For 32 bit applications 
	# Only available on unstable
	hardware.opengl.extraPackages32 = with pkgs; [
		driversi686Linux.amdvlk
	];

}
