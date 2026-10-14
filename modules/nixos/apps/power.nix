{...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkSystem pkgs) [
          {name = "acpi";}
          {name = "brightnessctl";}
        ];
      }
    )
  ];
}
