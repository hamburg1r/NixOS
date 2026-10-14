{...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkSystem pkgs) [
          {name = "gparted";}
          {name = "zenity";}
          {name = "libnotify";}
          {name = "libqalculate";}
          {name = "ydotool";}
          {name = "wl-clipboard";}
          {name = "ffmpegthumbnailer";}
          {name = "nemo";}
          {name = "ristretto";}
          {name = "firefox";}
          {name = "mpv";}
          {name = "usbutils";}
          {
            name = "sddm-kcm";
            pkg = ["kdePackages" "sddm-kcm"];
          }
        ];
      }
    )
  ];
}
