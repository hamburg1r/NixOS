{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.vulkan-tools;
      in {
        options.desktop.apps.vulkan-tools = {
          enable = lib.mkEnableOption "the Vulkan tools";
          package = lib.mkPackageOption pkgs "vulkan-tools" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
