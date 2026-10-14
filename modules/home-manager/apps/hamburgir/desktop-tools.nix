{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "awww";}
          {name = "keepassxc";}
          {name = "wayshot";}
          {name = "slurp";}
          {name = "swappy";}
          {name = "rofi";}
        ];
      }
    )
  ];
}
