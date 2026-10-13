{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {pkgs, ...}: {
        home.packages = with pkgs; [
          # grim
          wayshot
          slurp
          swappy
          # satty
          rofi
          qbittorrent
          peazip
          obsidian
        ];
        programs.zathura.enable = true;
      }
    )
  ];
}
