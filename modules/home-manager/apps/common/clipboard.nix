{...}: {
  config.dendritic.home.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "cliphist";}
          {name = "wl-clipboard";}
        ];
      }
    )
  ];
}
