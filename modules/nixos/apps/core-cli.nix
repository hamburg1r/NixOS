{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        mkPkg = spec: let
          name = spec.name;
          pkg = spec.pkg or name;
        in {
          options.desktop.apps.${name} = {
            enable = lib.mkEnableOption name;
            package = lib.mkPackageOption pkgs pkg {};
          };
          config = lib.mkIf config.desktop.apps.${name}.enable {
            environment.systemPackages = [config.desktop.apps.${name}.package];
          };
        };

        mtr = config.desktop.apps.mtr;
      in {
        imports =
          map mkPkg [
            {name = "git";}
            {name = "wget";}
            {name = "ripgrep";}
            {name = "fd";}
            {name = "lf";}
            {name = "trash-cli";}
            {name = "unzip";}
            {name = "unrar";}
            {name = "lz4";}
            {name = "neovim";}
          ]
          ++ [
            {
              options.desktop.apps.mtr = {
                enable = lib.mkEnableOption "mtr, a network diagnostic tool";
                package = lib.mkPackageOption pkgs "mtr" {};
              };

              config = lib.mkIf mtr.enable {
                programs.mtr = {
                  enable = lib.mkDefault true;
                  package = mtr.package;
                };
              };
            }
          ];
      }
    )
  ];
}
