{config, ...}: {
  config.dendritic.home.disabled = [
    (
      {...}: {
        vim.ui.noice = {
          enable = true;
        };
      }
    )
  ];
}
