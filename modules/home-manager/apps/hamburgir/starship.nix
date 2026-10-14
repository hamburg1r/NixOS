{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        lib,
        pkgs,
        outputs,
        ...
      }: {
        imports = [
          (outputs.lib.mkProgram pkgs "starship" {
            name = "starship";
            description = "starship, a cross-shell prompt";
            enable = true;
            settings = {
              enableBashIntegration = true;
              enableZshIntegration = true;
              settings = {
                add_newline = false;
                format = pkgs.lib.concatStrings [
                  # "[╭](black)" "$fill" "$nix_shell" "[╮](black)" "$line_break"
                  # "│" "─"
                  # "│" "─"
                  # "[╰](black)" "$os" "[\\[ $directory \\]](blue)" "[─](black)" "$character" # "╯"

                  "$os"
                  "$directory"
                  "$c"
                  "\n"
                  "$username"
                  "$character"

                  # "$username" "$directory" "$character"
                ];
                right_format = pkgs.lib.concatStrings [
                  # "$time" "$cmd_duration" "[╯](black)"
                  "$time"
                  "$cmd_duration"
                  "$nix_shell"

                  # "$time" "$cmd_duration"
                ];
                c = {
                  # format = "";
                  symbol = " ";
                };
                # character = {
                #     success_symbol = "[➜](bold green) ";
                #     error_symbol = "[➜](bold red) ";
                # };
                cmd_duration = {
                  format = "[ $duration]($style)";
                  show_notifications = true;
                  min_time_to_notify = 20000;
                };
                directory = {
                  format = "in [$path ]($style)[$read_only]($read_only_style)";
                  fish_style_pwd_dir_length = 1;
                  # home_symbol = "󰋜";
                  read_only = " ";
                  style = "blue bold";
                };
                fill = {
                  symbol = "─";
                  style = "black";
                };
                nix_shell = {
                  format = "[$symbol$state( \\($name\\))]($style)";
                  symbol = "󱄅 ";
                  heuristic = true;
                };
                os = {
                  format = "[$symbol]($style)";
                  disabled = false;
                  style = "blue dimmed";
                  symbols = {
                    NixOS = "󱄅 ";
                  };
                };
                time = {
                  format = "[$time]($style) ";
                  style = "white";
                  use_12hr = true;
                  disabled = false;
                };
                username = {
                  style_user = "green bold";
                  style_root = "red bold";
                };
              };
            };
          })
        ];

        config.desktop.apps.starship.enable = lib.mkDefault true;
      }
    )
  ];
}
