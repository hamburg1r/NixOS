{...}: {
  config.dendritic.nixos.microwave = [
    (
      {...}: {
        time.timeZone = "Asia/Kolkata";
      }
    )
  ];
}
