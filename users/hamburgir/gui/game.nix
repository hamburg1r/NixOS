{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {pkgs, ...}: {
        home.packages = with pkgs; [
          # prismlauncher
          gamescope
          faugus-launcher
          # heroic
          steam
          steam-run
        ];
      }
    )
  ];
}
