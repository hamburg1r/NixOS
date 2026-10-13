{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.acpi;
      in {
        options.desktop.apps.acpi = {
          enable = lib.mkEnableOption "acpi, for battery/power info";
          package = lib.mkPackageOption pkgs "acpi" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
