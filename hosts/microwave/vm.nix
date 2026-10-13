{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {...}: {
        virtualisation = {
          docker = {
            enable = false;
            rootless = {
              enable = true;
              setSocketVariable = true;
            };
          };
          podman = {
            enable = true;
            # Create a `docker` alias for podman, to use it as a drop-in replacement
            dockerCompat = true;

            defaultNetwork.settings = {
              dns_enabled = true;
            };
          };
        };
      }
    )
  ];
}
