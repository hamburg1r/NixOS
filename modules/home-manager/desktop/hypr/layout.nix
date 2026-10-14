{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        ...
      }: {
        options.desktop.hyprland.layoutName = lib.mkOption {
          type = lib.types.enum ["dwindle" "master" "hy3"];
          default = "dwindle";
          description = "Name of the layout manager for Hyprland.";
        };

        config = {
          wayland.windowManager.hyprland.settings.general.layout = config.desktop.hyprland.layoutName;
        };
      }
    )
  ];
}
