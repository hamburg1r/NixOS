{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.virt-manager;
      in {
        options.desktop.apps.virt-manager = {
          enable = lib.mkEnableOption "virt-manager, a virtual machine manager";
          package = lib.mkPackageOption pkgs "virt-manager" {};
        };

        config = lib.mkIf cfg.enable {
          programs.virt-manager = {
            enable = true;
            package = cfg.package;
          };
        };
      }
    )
  ];
}
