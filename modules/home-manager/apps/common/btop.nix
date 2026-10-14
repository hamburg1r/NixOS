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
            options.desktop.apps.btop = {
              enable = lib.mkEnableOption "btop, a resource monitor";
              package = lib.mkPackageOption pkgs "btop" {};
            };

            config = lib.mkIf config.desktop.apps.btop.enable {
              programs.btop = {
                enable = true;
                package = config.desktop.apps.btop.package;
              };
            };
          }
        ];

        config.desktop.apps.btop.enable = lib.mkDefault true;
      }
    )
  ];
}
