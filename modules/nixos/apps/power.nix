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

        services.logind.settings.Login = {
          HandlePowerKey = "suspend";
          HandlePowerKeyLongPress = "poweroff";
          HandleSuspendKey = "suspend";
          HandleHibernateKey = "ignore";
          IdleAction = "ignore";
        };

        systemd.sleep.settings.Sleep = {
          AllowSuspend = "yes";
          AllowHibernation = "no";
          AllowSuspendThenHibernate = "no";
          AllowHybridSleep = "no";
        };
      }
    )
  ];
}
