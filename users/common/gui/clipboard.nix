{config, ...}: {
  config.dendritic.home.common = [
    (
      {pkgs, ...}: {
        home.packages = with pkgs; [
          cliphist
          wl-clipboard
        ];
      }
    )
  ];
}
