{...}: {
  config.dendritic.nixos.common = [
    (
      {
        config,
        inputs,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.niri;
      in {
        options.desktop.apps.niri = {
          enable = lib.mkEnableOption "niri, a scrollable-tiling Wayland compositor";
          package = lib.mkOption {
            type = lib.types.package;
            default = inputs.niri.packages."${pkgs.stdenv.hostPlatform.system}".niri-unstable;
            defaultText = lib.literalExpression ''inputs.niri.packages."''${pkgs.stdenv.hostPlatform.system}".niri-unstable'';
            description = "The niri package to install.";
          };
        };

        config = lib.mkIf cfg.enable {
          programs.niri = {
            enable = true;
            package = cfg.package;
          };
        };
      }
    )
  ];
}
