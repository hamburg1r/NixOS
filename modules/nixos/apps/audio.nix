{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkSystem pkgs) [
          {name = "pwvucontrol";}
          {
            name = "easyeffects";
            pkg = ["stable" "easyeffects"];
          }
          {name = "crosspipe";}
        ];
      }
    )
  ];
}
