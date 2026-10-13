{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.vulkan-loader;
      in {
        options.desktop.apps.vulkan-loader = {
          enable = lib.mkEnableOption "the Vulkan loader";
          package = lib.mkPackageOption pkgs "vulkan-loader" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
