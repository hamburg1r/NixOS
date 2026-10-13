{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        direnv = config.desktop.apps.direnv;
      in {
        imports =
          [
            {
              options.desktop.apps.direnv = {
                enable = lib.mkEnableOption "direnv, for per-directory environments";
                package = lib.mkPackageOption pkgs "direnv" {};
              };

              config = lib.mkIf direnv.enable {
                programs.direnv = {
                  enable = true;
                  package = direnv.package;
                };
              };
            }
          ]
          ++ (let
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
          in
            map mkPkg [
              {name = "devenv";}
            ]);
      }
    )
  ];
}
