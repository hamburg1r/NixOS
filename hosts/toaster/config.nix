# General host config and high-level feature toggles for toaster.
#
# `dendritic.features.toaster` is threaded into the NixOS evaluation as the
# `features` special argument and consulted by the app baselines
# (e.g. hosts/common/apps.nix) to enable/disable whole feature groups.
{...}: {
  config.dendritic.features.toaster = {
    gaming = true;
    development = true;
  };

  config.dendritic.nixos.toaster = [
    (
      {...}: {
        users.users.hamburgir.openssh.authorizedKeys.keys = [
        ];
      }
    )
  ];
}
