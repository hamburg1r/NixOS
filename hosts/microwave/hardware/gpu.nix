{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {pkgs, ...}: {
        boot.initrd.kernelModules = ["amdgpu"];
        services.xserver.videoDrivers = ["amdgpu"];

        hardware.graphics = {
          enable = true;
          enable32Bit = true;

          extraPackages = with pkgs; [
            vulkan-loader
            vulkan-validation-layers
            vulkan-extension-layer

            mesa

            libGL
            libGLU
          ];
          # For 32 bit applications
          extraPackages32 = with pkgs; [
            vulkan-loader
            driversi686Linux.mesa
          ];
        };
      }
    )
  ];
}
