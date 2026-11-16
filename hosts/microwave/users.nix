{...}: {
  config.dendritic.nixos.microwave = [
    (
      {lib, pkgs, ...}: {
        users.users.hamburgir = {
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
