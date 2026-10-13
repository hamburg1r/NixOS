{config, ...}: {
  config.dendritic.nixos.toaster = [
    (
      {...}: {
        time.timeZone = "Asia/Kolkata";
      }
    )
  ];
}
