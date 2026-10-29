{...}: {
  config.dendritic.nixos.microwave = [
    (
      {...}: {
        custom.plymouth = {
          enable = true;
          theme.name = "owl";
        };
      }
    )
  ];
}
