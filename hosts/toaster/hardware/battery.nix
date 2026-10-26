{...}: {
  config.dendritic.nixos.toaster = [
    (
      {inputs, ...}: {
        imports = [inputs.nixos-hardware.nixosModules.asus-battery];

        hardware.asus.battery.chargeUpto = 60;

        services.logind.settings.Login = {
          HandleLidSwitch = "suspend";
          HandleLidSwitchExternalPower = "suspend";
          HandleLidSwitchDocked = "ignore";
        };
      }
    )
  ];
}
