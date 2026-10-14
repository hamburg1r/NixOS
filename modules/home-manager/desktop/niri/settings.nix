{...}: {
  config.dendritic.home.hamburgir = [
    (
      {...}: {
        programs.niri.settings = {
          prefer-no-csd = true;
        };
      }
    )
  ];
}
