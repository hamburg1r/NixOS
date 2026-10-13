{config, ...}: {
  config.dendritic.home.common = [
    (
      {pkgs, ...}: {
        home.packages = with pkgs; [
          nemo
          # thunar
          ristretto
          # spotify
          pear-desktop # youtube-music
        ];
      }
    )
  ];
}
