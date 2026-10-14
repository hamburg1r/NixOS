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
          (outputs.lib.mkProgram pkgs "git" {
            name = "git";
            description = "git, the version control system";
            settings = {
              ignores = lib.mkDefault ["*.tmp" "*.temp" "tmp.*" "temp.*"];
              settings = {
                init.defaultBranch = "main";
                pull.rebase = true;
              };
            };
          })
        ];

        config.desktop.apps.git.enable = lib.mkDefault true;
      }
    )
  ];
}
