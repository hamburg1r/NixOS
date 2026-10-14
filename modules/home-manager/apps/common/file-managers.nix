{config, ...}: {
  config.dendritic.home.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "nemo";}
          {name = "ristretto";}
        ];
      }
    )
  ];
}
