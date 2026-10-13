{config, ...}: {
  config.dendritic.home.disabled = [
    (
      {...}: {
        vim.theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };
      }
    )
  ];
}
