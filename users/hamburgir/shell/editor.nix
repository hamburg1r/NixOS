{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        inputs,
        pkgs,
        ...
      }: {
        home = {
          packages = [
            # pkgs.neovim
            inputs.nixvimConfig.packages."${pkgs.stdenv.hostPlatform.system}".default
            # inputs.mcp-hub.packages."x86_64-linux".default
            pkgs.jetbrains.idea
          ];
          shellAliases = {
            vi = "nvim";
            vim = "nvim";
          };
        };
      }
    )
  ];
}
