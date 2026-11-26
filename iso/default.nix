{
  inputs,
  config,
  lib,
  modulesPath,
  outputs,
  pkgs,
  system,
  ...
}: let
  secretDir = builtins.getEnv "ISO_SECRETS_DIR";
  hasApiKey = secretDir != "";
  isoFile = name:
    if secretDir == "" then
      throw "ISO secrets missing: run nix run .#build-iso (prompts for the OpenAI API key)."
    else if !builtins.pathExists "${secretDir}/${name}" then
      throw "ISO secret ${name} missing: run nix run .#build-iso."
    else
      builtins.path {
        path = "${secretDir}/${name}";
        name = "iso-${name}";
      };
in {
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

  # The build helper supplies an ephemeral ISO-only identity and ciphertext.
  # Both end up in the Nix store and ISO, but not in this repository.
  sops = lib.mkIf hasApiKey {
    age = {
      keyFile = "/etc/sops/age/iso-key.txt";
      sshKeyPaths = [];
    };
    gnupg.sshKeyPaths = [];
    secrets.openai_api_key = {
      sopsFile = isoFile "openai_api_key";
      format = "binary";
      owner = "nixos";
      mode = "0400";
    };
  };

  # SOPS needs the /etc symlink to exist before its activation step runs.
  system.activationScripts = lib.mkIf hasApiKey {
    setupSecrets.deps = ["etc"];
  };
  environment.etc."sops/age/iso-key.txt" = lib.mkIf hasApiKey {
    source = isoFile "age-key.txt";
  };
  environment.etc."opencode/opencode.json".text = builtins.toJSON (
    {
      "$schema" = "https://opencode.ai/config.json";
    }
    // lib.optionalAttrs hasApiKey {
      model = "openai/gpt-6.1-sol";
      providers.openai.settings.apiKey = "{file:${config.sops.secrets.openai_api_key.path}}";
    }
  );

  environment.systemPackages = with pkgs; [
    cryptsetup
    efibootmgr
    fd
    git
    gptfdisk
    mokutil
    neovim
    opencode
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
