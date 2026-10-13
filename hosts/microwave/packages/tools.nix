{config, ...}: {
  config.dendritic.nixos.microwave = [
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
