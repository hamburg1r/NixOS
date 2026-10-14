{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "gamescope";}
          {name = "faugus-launcher";}
          {name = "steam";}
          {name = "steam-run";}
        ];
      }
    )
  ];
}
