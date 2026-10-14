{...}: {
  config.dendritic.nixos.toaster = [
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
