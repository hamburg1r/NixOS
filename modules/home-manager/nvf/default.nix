{config, ...}: {
  config.dendritic.home.disabled = [
    (
      {...}: {
        vim.lazy.enable = true;
      }
    )
  ];
}
