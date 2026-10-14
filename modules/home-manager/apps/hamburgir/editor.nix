{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        inputs,
        config,
        lib,
        pkgs,
        ...
      }: let
        nixvim = config.desktop.apps.nixvim;
        idea = config.desktop.apps.idea;
      in {
        options.desktop.apps.nixvim = {
          enable = lib.mkEnableOption "nixvim, the standalone Neovim configuration";
          package = lib.mkOption {
            type = lib.types.package;
            default = inputs.nixvimConfig.packages."${pkgs.stdenv.hostPlatform.system}".default;
            defaultText = lib.literalExpression ''inputs.nixvimConfig.packages."''${pkgs.stdenv.hostPlatform.system}".default'';
            description = "The nixvim package to install.";
          };
        };

        options.desktop.apps.idea = {
          enable = lib.mkEnableOption "JetBrains IDEA";
          package = lib.mkPackageOption pkgs ["jetbrains" "idea"] {};
        };

        config = {
          home.shellAliases = {
            vi = "nvim";
            vim = "nvim";
          };

          home.packages =
            lib.optionals nixvim.enable [nixvim.package]
            ++ lib.optionals idea.enable [idea.package];
        };
      }
    )
  ];
}
