{...}: {
  config.dendritic.home.hamburgir = [
    (
      {...}: {
        programs = {
          zellij = {
            enableBashIntegration = false;
            enableZshIntegration = false;
            enableFishIntegration = false;
          };
        };
      }
    )
  ];
}
