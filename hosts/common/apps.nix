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
          git.enable = true;
          lf.enable = true;
          lz4.enable = true;
          neovim.enable = true;
          nix-output-monitor.enable = true;
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
