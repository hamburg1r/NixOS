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
            name = "sway";
            pkg = "swayfx";
            description = "sway, an i3-compatible Wayland compositor";
            install = cfg: {
              wayland.windowManager.sway = {
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
