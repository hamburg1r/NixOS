{
	pkgs,
	...
}: {
	boot.initrd.kernelModules = [ "amdgpu" ];
	services.xserver.videoDrivers = [ "amdgpu" ];

	hardware.graphics = {
		enable = true;
		enable32Bit = true;
		# For 32 bit applications
		# driSupport32Bit = true;

		extraPackages = with pkgs; [
			vulkan-loader
			vulkan-validation-layers
			vulkan-extension-layer

			mesa
			amdvlk

			libGL
			libGLU
		];
		# For 32 bit applications 
		# Only available on unstable
		extraPackages32 = with pkgs; [
			vulkan-loader
			driversi686Linux.mesa
			# driversi686Linux.amdvlk
		];
	};

}
