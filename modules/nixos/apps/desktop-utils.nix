{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        mkPkg = spec: let
          name = spec.name;
          pkg = spec.pkg or name;
        in {
          options.desktop.apps.${name} = {
            enable = lib.mkEnableOption name;
            package = lib.mkPackageOption pkgs pkg {};
          };
          config = lib.mkIf config.desktop.apps.${name}.enable {
            environment.systemPackages = [config.desktop.apps.${name}.package];
          };
        };
      in {
        imports = map mkPkg [
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
