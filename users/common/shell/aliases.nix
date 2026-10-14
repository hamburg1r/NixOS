{...}: {
  config.dendritic.home.common = [
    (
      {...}: {
        home.shellAliases = {
          la = "ls -A";
          ll = "ls -l";
          lla = "ls -la";
        };
      }
    )
  ];
}
