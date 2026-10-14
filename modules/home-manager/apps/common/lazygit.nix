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
            options.desktop.apps.lazygit = {
              enable = lib.mkEnableOption "lazygit, a terminal UI for git";
              package = lib.mkPackageOption pkgs "lazygit" {};
            };

            config = lib.mkIf config.desktop.apps.lazygit.enable {
              programs.lazygit = {
                enable = true;
                package = config.desktop.apps.lazygit.package;
              };
            };
          }
        ];

        config.desktop.apps.lazygit.enable = lib.mkDefault true;
      }
    )
  ];
}
