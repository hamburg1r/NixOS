{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkSystem pkgs) [
          {name = "vulkan-loader";}
          {name = "vulkan-tools";}
          {name = "mangohud";}
        ];
      }
    )
  ];
}
