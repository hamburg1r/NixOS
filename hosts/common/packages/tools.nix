{config, ...}: {
  config.dendritic.nixos.common = [
    (
      {lib, ...}: {
        services.upower = {
          enable = lib.mkDefault true;
        };
      }
    )
  ];
}
