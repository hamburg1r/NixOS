{
  inputs,
  config,
  lib,
  modulesPath,
  outputs,
  pkgs,
  system,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
    hostPlatform = system;
  };

  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      accept-flake-config = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://hamburgir.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "hamburgir.cachix.org-1:KMZ+IBiEsG1s+wrw3+Dh14ZC0aGZucZivjbN7qMZK7Q="
      ];
      trusted-users = [
        "root"
        "nixos"
        "hamburgir"
      ];
    };
  };

  networking = {
    hostName = "iso";
    # Installer images enable wpa_supplicant; it conflicts with NetworkManager.
    # Wi-Fi still works through NM.
    wireless.enable = lib.mkForce false;
    networkmanager.enable = true;
  };

  services.openssh.enable = true;

  # Faster to build than the default xz; still fine for a recovery stick.
  image.baseName = lib.mkForce "nixos-toaster";

  isoImage = {
    volumeID = "NIXOS_TOASTER";
    squashfsCompression = "zstd -Xcompression-level 6";
    makeEfiBootable = true;
    makeUsbBootable = true;
  };

  boot.zfs.forceImportRoot = false;

  environment.systemPackages = with pkgs; [
    cryptsetup
    efibootmgr
    fd
    git
    gptfdisk
    mokutil
    neovim
    parted
    pciutils
    ripgrep
    sbctl
    usbutils
  ];

  programs = {
    nh.enable = true;
    zsh.enable = true;
  };

  system.stateVersion = "24.05";
}
