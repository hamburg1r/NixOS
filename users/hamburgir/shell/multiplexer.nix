{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        pkgs,
        ...
      }: {
        programs = {
          tmux = {
            enable = true;
          };
          zellij = {
            enable = true;
            enableBashIntegration = false;
            enableZshIntegration = false;
            enableFishIntegration = false;
          };
        };
      }
    )
  ];
}
