{config, ...}: {
  config.dendritic.nixos.microwave = [
    (
      {pkgs, ...}: {
        users.users.hamburgir = {
          isNormalUser = true;
          description = "Shantnu Biswas";
          extraGroups = [
            "networkmanager"
            "wheel"
            "storage"
            "input"
          ];
          openssh.authorizedKeys.keys = [
          ];
          homeMode = "755";
          shell = pkgs.zsh;
        };
      }
    )
  ];
}
