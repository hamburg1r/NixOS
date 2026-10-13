{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {
        inputs,
        outputs,
        pkgs,
        lib,
        config,
        ...
      }: {
        imports = [inputs.niri.nixosModules.niri];

        wallpaper.sddm = {
          dir = "your_name";
          file = "VillageComet.jpg";
        };

        services.xserver.desktopManager = {
          xfce.enable = false;
        };
        services.desktopManager = {
          plasma6.enable = false;
          gnome.enable = true;
        };

        services.xserver.windowManager = {
          qtile.enable = false;
          i3.enable = true;
          herbstluftwm.enable = false;
          awesome = {
            enable = false;
            luaModules = with pkgs.luaPackages; [
              luarocks
              luadbi-mysql
            ];
          };
        };

        services.xserver.excludePackages = [pkgs.xterm];

        programs.droidcam.enable = true;
        programs.sway.enable = true;

        # Configure keymap in X11
        services.xserver = {
          enable = true;
          xkb = {
            layout = "us";
            variant = "";
          };
        };
        services.gnome.gnome-keyring.enable = true;
        programs.hyprland = {
          enable = true;
          xwayland.enable = true;
        };
        programs.niri = {
          enable = true;
          package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
        };

        security.polkit.enable = true;

        programs.appimage = {
          enable = true;
          binfmt = true;
        };
      }
    )
  ];
}
