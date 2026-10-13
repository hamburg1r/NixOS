{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {...}: {
        desktop.apps = {
          acpi.enable = true;
          brightnessctl.enable = true;
          crosspipe.enable = true;
          easyeffects.enable = true;
          fd.enable = true;
          fira-code.enable = true;
          fira-code-symbols.enable = true;
          git.enable = true;
          lf.enable = true;
          liberation-ttf.enable = true;
          lz4.enable = true;
          mtr.enable = true;
          neovim.enable = true;
          nh.enable = true;
          nix-output-monitor.enable = true;
          noto-fonts.enable = true;
          noto-fonts-cjk-sans.enable = true;
          noto-fonts-color-emoji.enable = true;
          nvd.enable = true;
          pwvucontrol.enable = true;
          ripgrep.enable = true;
          trash-cli.enable = true;
          unrar.enable = true;
          unzip.enable = true;
          wget.enable = true;
          zsh.enable = true;
        };
      }
    )
  ];
}
