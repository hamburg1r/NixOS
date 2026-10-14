{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkApp pkgs {
            name = "hyprland";
            description = "hyprland, a dynamic tiling Wayland compositor";
            install = cfg: {
              wayland.windowManager.hyprland = {
                enable = true;
                package = cfg.package;
              };
            };
          })
        ];
      }
    )
  ];
}
