# General host config and high-level feature toggles for toaster.
#
# `dendritic.features.toaster` is threaded into the NixOS evaluation as the
# `features` special argument and consulted by the app baselines
# (e.g. hosts/common/apps.nix) to enable/disable whole feature groups.
{...}: {
  config.dendritic.features.toaster = {
    gaming = false;
    development = false;
  };

  config.dendritic.nixos.toaster = [
    (
      {lib, ...}: {
        programs.nh.flake = lib.mkForce "/home/ham/repo/NixOS";
      }
    )
  ];
}
