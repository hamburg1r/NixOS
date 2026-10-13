{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {inputs, ...}: {
        services = {
          displayManager = {
            gdm.enable = false;
          };
          greetd = {
            enable = false;
            settings = {
              default_session = {
                command = "${inputs}/bin/greeter";
              };
            };
          };
        };
      }
    )
  ];
}
