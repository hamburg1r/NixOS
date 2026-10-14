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
            options.desktop.apps.git = {
              enable = lib.mkEnableOption "git, the version control system";
              package = lib.mkPackageOption pkgs "git" {};
            };

            config = lib.mkIf config.desktop.apps.git.enable {
              programs.git = {
                enable = true;
                package = config.desktop.apps.git.package;
                ignores = lib.mkDefault ["*.tmp" "*.temp" "tmp.*" "temp.*"];
                settings = {
                  init.defaultBranch = "main";
                  pull.rebase = true;
                };
              };
            };
          }
        ];

        config.desktop.apps.git.enable = lib.mkDefault true;
      }
    )
  ];
}
