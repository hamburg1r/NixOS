{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {features, ...}: {
        desktop.apps = {
          acpi.enable = true;
          brightnessctl.enable = true;
          crosspipe.enable = true;
          devenv.enable = features.development or true;
          direnv.enable = features.development or true;
          distrobox.enable = true;
          easyeffects.enable = true;
          fd.enable = true;
          ffmpegthumbnailer.enable = true;
          fira-code.enable = true;
          fira-code-symbols.enable = true;
          firefox.enable = true;
          gamescope.enable = features.gaming or true;
          git.enable = true;
          gparted.enable = true;
          hyprland.enable = true;
          i3.enable = true;
          libnotify.enable = true;
          libqalculate.enable = true;
          lf.enable = true;
          liberation-ttf.enable = true;
          lz4.enable = true;
          mangohud.enable = features.gaming or true;
          mpv.enable = true;
          mtr.enable = true;
          nemo.enable = true;
          neovim.enable = true;
          nh.enable = true;
          nix-output-monitor.enable = true;
          niri.enable = true;
          noto-fonts.enable = true;
          noto-fonts-cjk-sans.enable = true;
          noto-fonts-color-emoji.enable = true;
          nvd.enable = true;
          pwvucontrol.enable = true;
          ripgrep.enable = true;
          ristretto.enable = true;
          sbctl.enable = true;
          steam.enable = features.gaming or true;
          sway.enable = true;
          trash-cli.enable = true;
          unrar.enable = true;
          unzip.enable = true;
          usbutils.enable = true;
          virt-manager.enable = true;
          vulkan-loader.enable = true;
          vulkan-tools.enable = true;
          wget.enable = true;
          wl-clipboard.enable = true;
          ydotool.enable = true;
          zenity.enable = true;
          zsh.enable = true;
        };
      }
    )
  ];
}
