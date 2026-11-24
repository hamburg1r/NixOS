{...}: {
  config.dendritic.nixos.toaster = [
    (
      {config, pkgs, ...}: {
        sops.secrets."hosts/toaster/passwords/ham" = {
          sopsFile = ../../secrets/hosts/toaster/passwords/ham;
          format = "binary";
          neededForUsers = true;
        };
        sops.secrets."hosts/toaster/passwords/root" = {
          sopsFile = ../../secrets/hosts/toaster/passwords/root;
          format = "binary";
          neededForUsers = true;
        };

        users.users.root.hashedPasswordFile = config.sops.secrets."hosts/toaster/passwords/root".path;
        nix.settings.trusted-users = ["ham"];
        users.users.ham = {
          hashedPasswordFile = config.sops.secrets."hosts/toaster/passwords/ham".path;
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
