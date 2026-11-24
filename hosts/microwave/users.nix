{...}: {
  config.dendritic.nixos.microwave = [
    (
      {config, lib, pkgs, ...}: {
        sops.secrets."hosts/microwave/passwords/hamburgir" = {
          sopsFile = ../../secrets/hosts/microwave/passwords/hamburgir;
          format = "binary";
          neededForUsers = true;
        };
        sops.secrets."hosts/microwave/passwords/root" = {
          sopsFile = ../../secrets/hosts/microwave/passwords/root;
          format = "binary";
          neededForUsers = true;
        };

        users.users.root.hashedPasswordFile = config.sops.secrets."hosts/microwave/passwords/root".path;
        users.users.hamburgir = {
          hashedPasswordFile = config.sops.secrets."hosts/microwave/passwords/hamburgir".path;
          isNormalUser = true;
          description = "Shantnu Biswas";
          extraGroups = [
            "networkmanager"
            "wheel"
            "storage"
            "input"
          ];
          homeMode = "755";
          shell = pkgs.zsh;
          openssh.authorizedKeys.keys = [
            (lib.strings.removeSuffix "\n" (builtins.readFile ../../users/ham/ssh/id_ed25519.pub))
          ];
        };
      }
    )
  ];
}
