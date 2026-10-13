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
      in {
        imports = map mkPkg [
          {name = "acpi";}
          {name = "brightnessctl";}
        ];
      }
    )
  ];
}
