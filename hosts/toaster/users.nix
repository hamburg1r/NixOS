{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {pkgs, ...}: {
        users.users.hamburgir = {
          isNormalUser = true;
          description = "Shantnu Biswas";
          extraGroups = [
            # "adbusers"
            "networkmanager"
            "wheel"
            "storage"
            "input"
          ];
          homeMode = "755";
          shell = pkgs.zsh;
        };
      }
    )
  ];
}
