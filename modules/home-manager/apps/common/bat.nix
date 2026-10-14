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
            options.desktop.apps.bat = {
              enable = lib.mkEnableOption "bat, a cat clone with syntax highlighting";
              package = lib.mkPackageOption pkgs "bat" {};
            };

            config = lib.mkIf config.desktop.apps.bat.enable {
              programs.bat = {
                enable = true;
                package = config.desktop.apps.bat.package;
                config.tabs = lib.mkDefault "4";
              };
            };
          }
        ];

        config.desktop.apps.bat.enable = lib.mkDefault true;
      }
    )
  ];
}
