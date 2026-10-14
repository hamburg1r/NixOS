{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "hyprland" {
            name = "hyprland";
            description = "hyprland, a dynamic tiling Wayland compositor";
            settings.xwayland.enable = true;
          })
        ];
      }
    )
  ];
}
