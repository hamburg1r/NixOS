# General user config and high-level feature toggles for hamburgir.
#
# `dendritic.features.hamburgir` is threaded into the Home Manager evaluation
# as the `features` special argument and consulted by the user app baseline
# (users/hamburgir/apps.nix) to enable/disable whole feature groups.
{...}: {
  config.dendritic.features.hamburgir = {
    gaming = true;
  };

  # Other general user configuration can be registered here, e.g.:
  #   config.dendritic.home.hamburgir = [ ({...}: { home.sessionVariables = {...}; }) ];
}
