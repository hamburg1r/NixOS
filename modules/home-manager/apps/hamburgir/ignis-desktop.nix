{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        inputs,
        lib,
        pkgs,
        ...
      }: let
        cfg = config.desktop.apps.ignis-desktop;
      in {
        options.desktop.apps.ignis-desktop = {
          enable = lib.mkEnableOption "ignis, a desktop shell/widget framework";
          package = lib.mkOption {
            type = lib.types.package;
            default = inputs.ignis-config.packages."${pkgs.stdenv.hostPlatform.system}".ignis-desktop;
            defaultText = lib.literalExpression ''inputs.ignis-config.packages."''${pkgs.stdenv.hostPlatform.system}".ignis-desktop'';
            description = "The ignis-desktop package to install.";
          };
        };

        config = lib.mkIf cfg.enable {
          programs.ignis-desktop = {
            enable = true;
            package = cfg.package;
          };
        };
      }
    )
  ];
}
