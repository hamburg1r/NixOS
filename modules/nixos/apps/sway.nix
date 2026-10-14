{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "sway" {
            name = "sway";
            description = "sway, an i3-compatible Wayland compositor";
          })
        ];
      }
    )
  ];
}
