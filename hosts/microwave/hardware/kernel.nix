{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {
        config,
        pkgs,
        lib,
        ...
      }: {
        boot = {
          initrd = {
            availableKernelModules = [
              "xhci_pci"
              "ahci"
              "usb_storage"
              "nvme"
              "sd_mod"
            ];
            kernelModules = [];
          };
          kernelModules = [
            "kvm-amd"
          ];
          kernelParams = lib.mkIf (!config.custom.plymouth.enable) [
            "quiet"
            "udev.log_level=3"
          ];
          kernelPackages = pkgs.linuxPackages_latest;
          consoleLogLevel = lib.mkIf (!config.custom.plymouth.enable) 3;
          initrd.verbose = lib.mkIf (!config.custom.plymouth.enable) true;
        };
      }
    )
  ];
}
