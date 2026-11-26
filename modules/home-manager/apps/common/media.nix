{...}: {
  config.dendritic.home.common = [
    (
      {
        pkgs,
        outputs,
        config,
        lib,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "pear-desktop";}
        ];

        xdg.configFile."YouTube Music Desktop App/config.json" = lib.mkIf config.desktop.apps.pear-desktop.enable {
          source = ./pear-desktop-settings.json;
          force = true;
        };
      }
    )
  ];
}
