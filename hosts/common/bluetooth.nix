{...}: {
  config.dendritic.nixos.toaster = [
    (
      {...}: {
        hardware.bluetooth = {
          settings = {
            General = {
              Enable = "Source,Sink,Media,Socket";
              ControllerMode = "dual";
            };
          };
        };
      }
    )
  ];
}
