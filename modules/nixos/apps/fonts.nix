{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        mkFont = spec: let
          name = spec.name;
          pkg = spec.pkg or name;
        in {
          options.desktop.apps.${name} = {
            enable = lib.mkEnableOption name;
            package = lib.mkPackageOption pkgs pkg {};
          };
          config = lib.mkIf config.desktop.apps.${name}.enable {
            fonts.packages = [config.desktop.apps.${name}.package];
          };
        };
      in {
        imports = map mkFont [
          {name = "noto-fonts";}
          {name = "noto-fonts-cjk-sans";}
          {name = "noto-fonts-color-emoji";}
          {
            name = "liberation-ttf";
            pkg = "liberation_ttf";
          }
          {name = "fira-code";}
          {name = "fira-code-symbols";}
        ];
      }
    )
  ];
}
