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
        imports = map mkApp [
          {name = "antigravity-ide";}
          {name = "antigravity-cli";}
          {name = "omniroute";}
          {name = "opencode";}
        ];
      }
    )
  ];
}
