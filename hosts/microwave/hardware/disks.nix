{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {inputs, ...}: {
        imports = [inputs.nixos-hardware.nixosModules.common-pc-ssd];
      }
    )
  ];
}
