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
          (outputs.lib.mkProgram pkgs "btop" {
            name = "btop";
            description = "btop, a resource monitor";
          })
        ];

        config.desktop.apps.btop.enable = lib.mkDefault true;
      }
    )
  ];
}
