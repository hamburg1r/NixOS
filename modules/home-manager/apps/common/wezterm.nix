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
            options.desktop.apps.wezterm = {
              enable = lib.mkEnableOption "wezterm, a GPU-accelerated terminal emulator";
              package = lib.mkPackageOption pkgs "wezterm" {};
            };

            config = lib.mkIf config.desktop.apps.wezterm.enable {
              programs.wezterm = {
                enable = true;
                package = config.desktop.apps.wezterm.package;
              };
            };
          }
        ];

        config.desktop.apps.wezterm.enable = lib.mkDefault false;
      }
    )
  ];
}
