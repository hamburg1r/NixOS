{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkHome pkgs {
            name = "xwaylandvideobridge";
            pkg = ["stable" "kdePackages" "xwaylandvideobridge"];
            description = "xwaylandvideobridge (must be running for Hyprland's XWayland video bridge rules)";
          })
        ];

        config.desktop.apps.xwaylandvideobridge.enable = lib.mkDefault true;
      }
    )
  ];
}
