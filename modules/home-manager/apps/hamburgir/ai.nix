{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "antigravity-ide";}
          {name = "antigravity-cli";}
          {name = "omniroute";}
          {name = "opencode";}
        ];
      }
    )
  ];
}
