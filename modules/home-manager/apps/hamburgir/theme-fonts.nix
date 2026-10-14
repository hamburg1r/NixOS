{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        ...
      }: {
        imports = [
          {
            options.desktop.apps.theme-fonts = {
              enable = lib.mkEnableOption "the theme's font set";
              packages = lib.mkOption {
                type = lib.types.listOf lib.types.package;
                default = config.userTheme.fonts.packages;
                description = "Font packages installed by the theme.";
              };
            };

            config = lib.mkIf config.desktop.apps.theme-fonts.enable {
              home.packages = config.desktop.apps.theme-fonts.packages;
            };
          }
        ];

        config.desktop.apps.theme-fonts.enable = lib.mkDefault true;
      }
    )
  ];
}
