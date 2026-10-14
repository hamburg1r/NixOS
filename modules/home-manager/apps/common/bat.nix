{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "bat" {
            name = "bat";
            description = "bat, a cat clone with syntax highlighting";
            settings.config.tabs = lib.mkDefault "4";
          })
        ];

        config.desktop.apps.bat.enable = lib.mkDefault true;
      }
    )
  ];
}
