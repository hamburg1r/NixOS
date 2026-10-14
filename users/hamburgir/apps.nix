{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {features, ...}: {
        desktop.apps = {
          alsa-utils.enable = true;
          ani-cli.enable = true;
          antigravity-cli.enable = true;
          antigravity-ide.enable = true;
          aria2.enable = true;
          awww.enable = true;
          bashmount.enable = true;
          crosspipe.enable = true;
          discord.enable = true;
          faugus-launcher.enable = features.gaming or true;
          gamescope.enable = features.gaming or true;
          homesync.enable = true;
          hyprland.enable = true;
          idea.enable = true;
          keepassxc.enable = true;
          lf.enable = true;
          mpv.enable = true;
          niri.enable = true;
          nixvim.enable = true;
          obsidian.enable = true;
          omniroute.enable = true;
          opencode.enable = true;
          pamixer.enable = true;
          peazip.enable = true;
          playerctl.enable = true;
          qbittorrent.enable = true;
          rofi.enable = true;
          slurp.enable = true;
          sshfs.enable = true;
          steam.enable = features.gaming or true;
          steam-run.enable = features.gaming or true;
          swappy.enable = true;
          taskwarrior.enable = true;
          vesktop.enable = true;
          wayshot.enable = true;
          zathura.enable = true;
        };
      }
    )
  ];
}
