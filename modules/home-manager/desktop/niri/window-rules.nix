{...}: {
  config.dendritic.home.hamburgir = [
    (
      {...}: {
        programs.niri.settings = {
          includes = [./nightreign.kdl];

          window-rules = [
            {
              matches = [
                {
                  app-id = "^firefox$";
                  title = "^Picture-in-Picture$";
                }
              ];
              open-floating = true;
            }
          ];
        };
      }
    )
  ];
}
