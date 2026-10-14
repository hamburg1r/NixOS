{...}: {
  config.dendritic.nixos.common = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkSystem pkgs {
            name = "sbctl";
            description = "sbctl, for Secure Boot key management";
          })
        ];
      }
    )
  ];
}
