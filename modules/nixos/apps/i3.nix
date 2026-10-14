{...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkApp pkgs {
            name = "i3";
            description = "i3, a tiling X11 window manager";
            install = cfg: {
              services.xserver.windowManager.i3 = {
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
