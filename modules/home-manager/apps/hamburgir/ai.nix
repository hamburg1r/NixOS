{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        pkgs,
        outputs,
        ...
      }: {
        imports = map (outputs.lib.mkHome pkgs) [
          {name = "antigravity-ide";}
          {name = "antigravity-cli";}
          {name = "opencode";}
        ];

        xdg.configFile."opencode/opencode.json" = {
          force = true;
          text = builtins.toJSON {
            "$schema" = "https://opencode.ai/config.json";
            mcp.servers = {
              context7 = {
                type = "remote";
                url = "https://mcp.context7.com/mcp";
              };
              rea = {
                type = "local";
                command = [
                  "${pkgs.rea}/bin/rea"
                  "mcp"
                ];
                disabled = false;
              };
            };
          };
        };
      }
    )
  ];
}
