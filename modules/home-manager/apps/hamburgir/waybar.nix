{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "waybar" {
            name = "waybar";
            description = "waybar, a highly customizable Wayland bar";
          })
        ];

        config.desktop.apps.waybar.enable = lib.mkDefault false;
      }
    )
  ];
}
