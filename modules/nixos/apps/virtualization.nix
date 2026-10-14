{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports =
          [
            (outputs.lib.mkProgram pkgs "virt-manager" {
              name = "virt-manager";
              description = "virt-manager, a virtual machine manager";
            })
          ]
          ++ map (outputs.lib.mkSystem pkgs) [
            {name = "distrobox";}
          ];
      }
    )
  ];
}
