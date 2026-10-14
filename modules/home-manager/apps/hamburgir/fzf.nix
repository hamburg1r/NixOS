{config, ...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        config,
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "fzf" {
            name = "fzf";
            description = "fzf, a command-line fuzzy finder";
            enable = true;
            settings = {
              changeDirWidget.command = "${pkgs.fd}/bin/fd --type d";
              colors = lib.mkForce {
                bg = "-1";
                "bg+" = "bright-black";
                fg = "white";
                "fg+" = "white";
                hl = "red:underline";
                "hl+" = "blue:bold";
                gutter = "bright-black";
                marker = "green";
                border = "bright-white";
                separator = "bright-white";
                scrollbar = "bright-black:bold";
                header = ":italic";
                query = "bright-white";
                info = "magenta";
                spinner = "cyan";
                pointer = "red:bold";
                prompt = "magenta";
              };
              defaultCommand = "${pkgs.fd}/bin/fd --type f";
              defaultOptions = [
                "--preview=${pkgs.pistol}/bin/pistol"
                "--border=rounded"
                "--marker=+"
                "--prompt=\\\" \\\""
                "--separator=󰼮"
                # "--separator="
                # "--separator=󰞍"
                "--scrollbar=┃"
              ];
            };
          })
        ];

        config.desktop.apps.fzf.enable = lib.mkDefault true;
      }
    )
  ];
}
