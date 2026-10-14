{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: {
        imports = [
          {
            options.desktop.apps.xwaylandvideobridge = {
              enable = lib.mkEnableOption "xwaylandvideobridge (must be running for Hyprland's XWayland video bridge rules)";
              package = lib.mkPackageOption pkgs ["stable" "kdePackages" "xwaylandvideobridge"] {};
            };

            config = lib.mkIf config.desktop.apps.xwaylandvideobridge.enable {
              home.packages = [config.desktop.apps.xwaylandvideobridge.package];
            };
          }
        ];

        config.desktop.apps.xwaylandvideobridge.enable = lib.mkDefault true;
      }
    )
  ];
}
