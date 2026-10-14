{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports =
          map (outputs.lib.mkHome pkgs) [
            {name = "obsidian";}
          ]
          ++ [
            (outputs.lib.mkProgram pkgs "zathura" {
              name = "zathura";
              description = "zathura, a document viewer";
            })
          ];
      }
    )
  ];
}
