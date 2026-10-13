{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {pkgs, ...}: {
        services.tumbler.enable = true;
        environment.systemPackages = with pkgs; [
          vulkan-loader
          vulkan-tools
          mpv
          ffmpegthumbnailer
          gparted
          zenity
          libnotify
          nemo
          ristretto
          wl-clipboard
          ydotool
          firefox
        ];
      }
    )
  ];
}
