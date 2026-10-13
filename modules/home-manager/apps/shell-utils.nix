{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        mkApp = spec: let
          name = spec.name;
          pkg = spec.pkg or name;
        in {
          options.desktop.apps.${name} = {
            enable = lib.mkEnableOption name;
            package = lib.mkPackageOption pkgs pkg {};
          };
          config = lib.mkIf config.desktop.apps.${name}.enable {
            home.packages = [config.desktop.apps.${name}.package];
          };
        };
      in {
        imports =
          map mkApp [
            {name = "sshfs";}
          ]
          ++ [
            (let
              cfg = config.desktop.apps.lf;
            in {
              options.desktop.apps.lf = {
                enable = lib.mkEnableOption "lf, a terminal file manager";
                package = lib.mkPackageOption pkgs "lf" {};
              };

              config = lib.mkIf cfg.enable {
                programs.lf.enable = true;
              };
            })
            (let
              cfg = config.desktop.apps.aria2;
            in {
              options.desktop.apps.aria2 = {
                enable = lib.mkEnableOption "aria2, a download utility";
                package = lib.mkPackageOption pkgs "aria2" {};
              };

              config = lib.mkIf cfg.enable {
                programs.aria2 = {
                  enable = true;
                  package = cfg.package;
                };
              };
            })
            (let
              cfg = config.desktop.apps.bashmount;
            in {
              options.desktop.apps.bashmount = {
                enable = lib.mkEnableOption "bashmount, a menu-driven block device mounter";
                package = lib.mkPackageOption pkgs "bashmount" {};
              };

              config = lib.mkIf cfg.enable {
                programs.bashmount = {
                  enable = true;
                  package = cfg.package;
                };
              };
            })
            (let
              cfg = config.desktop.apps.taskwarrior;
            in {
              options.desktop.apps.taskwarrior = {
                enable = lib.mkEnableOption "taskwarrior, a command-line TODO list manager";
                package = lib.mkPackageOption pkgs "taskwarrior3" {};
              };

              config = lib.mkIf cfg.enable {
                programs.taskwarrior = {
                  enable = true;
                  package = cfg.package;
                };
              };
            })
          ];
      }
    )
  ];
}
