{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {...}: {
        i18n.defaultLocale = "en_US.UTF-8";
      }
    )
  ];
}
