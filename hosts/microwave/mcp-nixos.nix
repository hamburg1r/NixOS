{...}: {
  config.dendritic.nixos.microwave = [
    (
      {pkgs, ...}: {
        environment.systemPackages = [pkgs.mcp-nixos];
      }
    )
  ];
}
