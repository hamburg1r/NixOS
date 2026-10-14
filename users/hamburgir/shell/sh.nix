{...}: {
  config.dendritic.home.hamburgir = [
    (
      {config, ...}: {
        # TODO: move stuff to common profile(potentially?)
        programs = {
          oh-my-posh = {
            enable = false;
            enableBashIntegration = config.programs.bash.enable;
            enableFishIntegration = config.programs.fish.enable;
            enableZshIntegration = config.programs.zsh.enable;
            # ompCfg = builtins.toFile "ompConf.json" (builtins.toString (builtins.replaceStrings [ "\\\\" ] [ "\\" ] (builtins.toJSON {
            settings = {
              "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
              version = 2;
              console_title_template = "{{.Folder}}{{if .Root}}::root{{end}}::{{.Shell}}";
              blocks = [
                {
                  type = "prompt";
                  newline = true;
                  alignment = "left";
                  segments = [
                    {
                      type = "path";
                      properties = {
                        # style = "unique";
                        style = "powerlevel";
                        max_width = 50;
                      };
                      template = "{{- .Path -}}";
                    }
                    {
                      type = "git";
                      style = "plain";
                    }
                    {
                      type = "root";
                      style = "plain";
                      foreground = "red";
                      template = "❄️";
                    }
                  ];
                }
                # {
                #	type = "prompt";
                #	alignment = "right";
                #	segments = [
                #	];
                # }
                {
                  type = "prompt";
                  newline = true;
                  alignment = "left";
                  segments = [
                    {
                      type = "text";
                      style = "plain";
                      foreground_templates = [
                        "{{if gt .Code 0}}red{{end}}"
                        "{{if eq .Code 0}}blue{{end}}"
                      ];
                      template = " ";
                    }
                  ];
                }
                {
                  type = "rprompt";
                  # alignment = "right";
                  segments = [
                    {
                      template = "❄️nix-{{ .Type }}";
                      type = "nix-shell";
                    }
                    {
                      type = "executiontime";
                      style = "plain";
                      foreground = "yellow";
                      properties = {
                        threshold = 5000;
                        style = "round";
                      };
                      template = "  {{ .FormattedMs }}";
                    }
                  ];
                }
              ];
              secondary_prompt = {
                foreground_templates = [
                  "{{if gt .Code 0}}red{{end}}"
                  "{{if eq .Code 0}}blue{{end}}"
                ];
                template = " ";
              };
              transient_prompt = {
                foreground_templates = [
                  "{{if gt .Code 0}}red{{end}}"
                  "{{if eq .Code 0}}blue{{end}}"
                ];
                template = " ";
              };
            };
          };
          command-not-found = {
            enable = true;
          };

          bash = {
            enable = true;
          };
        };
      }
    )
  ];
}
