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
            {name = "obsidian";}
          ]
          ++ [
            (let
              cfg = config.desktop.apps.zathura;
            in {
              options.desktop.apps.zathura = {
                enable = lib.mkEnableOption "zathura, a document viewer";
                package = lib.mkPackageOption pkgs "zathura" {};
              };

              config = lib.mkIf cfg.enable {
                programs.zathura = {
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
