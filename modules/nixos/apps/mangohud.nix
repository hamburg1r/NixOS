{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.mangohud;
      in {
        options.desktop.apps.mangohud = {
          enable = lib.mkEnableOption "MangoHud, a Vulkan/OpenGL overlay";
          package = lib.mkPackageOption pkgs "mangohud" {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
