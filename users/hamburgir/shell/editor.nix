{
    inputs,
    pkgs,
    ...
}: {
    home = {
        packages = [
            # pkgs.nvf # Saves memory
            # pkgs.neovim
            inputs.nixvimConfig.packages."${pkgs.stdenv.hostPlatform.system}".default
            # inputs.mcp-hub.packages."x86_64-linux".default
            pkgs.jetbrains.idea-oss
        ];
        shellAliases = {
            vi = "nvim";
            vim = "nvim";
        };
    };
    # programs.nvf.enable = false;
    # programs.nixvim.enable = false;
}
