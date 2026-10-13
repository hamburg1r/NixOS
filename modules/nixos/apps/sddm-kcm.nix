{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.sddm-kcm;
      in {
        options.desktop.apps.sddm-kcm = {
          enable = lib.mkEnableOption "the KDE SDDM configuration module";
          package = lib.mkPackageOption pkgs ["kdePackages" "sddm-kcm"] {};
        };

        config = lib.mkIf cfg.enable {
          environment.systemPackages = [cfg.package];
        };
      }
    )
  ];
}
