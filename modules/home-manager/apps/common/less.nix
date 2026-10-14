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
          (outputs.lib.mkProgram pkgs "less" {
            name = "less";
            description = "less, a terminal pager";
            settings.config = lib.mkDefault ''
              i quit
            '';
          })
        ];

        config.desktop.apps.less.enable = lib.mkDefault true;
      }
    )
  ];
}
