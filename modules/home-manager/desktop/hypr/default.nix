{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {...}: {
        wayland.windowManager.hyprland.configType = "lua";
      }
    )
  ];
}
