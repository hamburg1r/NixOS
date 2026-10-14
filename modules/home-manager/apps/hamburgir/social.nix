{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "discord";}
          {name = "vesktop";}
        ];
      }
    )
  ];
}
