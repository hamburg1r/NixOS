{...}: {
  config.dendritic.home.hamburgir = [
    (
      {...}: {
        programs.niri.settings = {
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
