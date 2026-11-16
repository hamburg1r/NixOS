{...}: {
  config.dendritic.nixos.toaster = [
    (
      {pkgs, ...}: {
        nix.settings.trusted-users = ["ham"];
        users.users.ham = {
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
          openssh.authorizedKeys.keys = [
            # hamburgir's public key on microwave; never copy the private key.
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDh/DI+GCjFMyJDze+7GUfmlBZ33fB9zXIk7hnJmfjMK hamburgir@microwave"
          ];
        };
      }
    )
  ];
}
