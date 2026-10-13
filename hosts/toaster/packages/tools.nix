{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {pkgs, ...}: {
        environment.systemPackages = with pkgs; [
          distrobox
          usbutils
          libqalculate
        ];
      }
    )
  ];
}
