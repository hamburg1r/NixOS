{config, ...}: {
  config.dendritic.home.disabled = [
    (
      {
        inputs,
        config,
        pkgs,
        ...
      }: {
        programs.nixvim = {
          extraPackages = with pkgs; [
            fd
            ripgrep
          ];
          viAlias = true;
          vimAlias = true;
        };
      }
    )
  ];
}
