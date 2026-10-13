# Top-level dendritic options. Every feature file self-registers its
# lower-level modules here; hosts compose them (see parts/hosts/*).
{lib, ...}: let
  list = lib.types.listOf lib.types.deferredModule;
in {
  options.dendritic = {
    overlays = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Repo overlays exposed to lower-level evaluations as `outputs.overlays`.";
    };

    nixos = {
      common = lib.mkOption {
        type = list;
        default = [];
        description = "NixOS modules shared by every host.";
      };
      toaster = lib.mkOption {
        type = list;
        default = [];
        description = "NixOS modules specific to toaster.";
      };
      microwave = lib.mkOption {
        type = list;
        default = [];
        description = "NixOS modules specific to microwave.";
      };
    };

    home = {
      common = lib.mkOption {
        type = list;
        default = [];
        description = "Home Manager modules shared by every user config.";
      };
      hamburgir = lib.mkOption {
        type = list;
        default = [];
        description = "Home Manager modules specific to hamburgir.";
      };
      disabled = lib.mkOption {
        type = list;
        default = [];
        description = "Modules kept around but not composed into any config.";
      };
    };
  };
}
