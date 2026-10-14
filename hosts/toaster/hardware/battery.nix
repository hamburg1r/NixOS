{...}: {
  config.dendritic.nixos.toaster = [
    (
      {inputs, ...}: {
        imports = [inputs.nixos-hardware.nixosModules.asus-battery];

        hardware.asus.battery.chargeUpto = 60;
      }
    )
  ];
}
