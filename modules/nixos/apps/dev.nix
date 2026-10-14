{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports =
          [
            (outputs.lib.mkProgram pkgs "direnv" {
              name = "direnv";
              description = "direnv, for per-directory environments";
            })
          ]
          ++ map (outputs.lib.mkSystem pkgs) [
            {name = "devenv";}
          ];
      }
    )
  ];
}
