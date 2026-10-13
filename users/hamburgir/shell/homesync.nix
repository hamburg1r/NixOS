{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        inputs,
        pkgs,
        ...
      }: {
        home.packages = [
          inputs.homesync.packages.${pkgs.system}.homesync-server
        ];
      }
    )
  ];
}
