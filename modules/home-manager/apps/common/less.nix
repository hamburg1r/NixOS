{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: {
        imports = [
          {
            options.desktop.apps.less = {
              enable = lib.mkEnableOption "less, a terminal pager";
              package = lib.mkPackageOption pkgs "less" {};
            };

            config = lib.mkIf config.desktop.apps.less.enable {
              programs.less = {
                enable = true;
                package = config.desktop.apps.less.package;
                config = lib.mkDefault ''
                  i quit
                '';
              };
            };
          }
        ];

        config.desktop.apps.less.enable = lib.mkDefault true;
      }
    )
  ];
}
