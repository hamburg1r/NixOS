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
          (outputs.lib.mkProgram pkgs "zsh" {
            name = "zsh";
            description = "the zsh shell";
            enable = true;
            settings = {
              initContent =
                ''
                  # eval "$(zellij setup --generate-auto-start zsh)"

                  # ZLE_RPROMPT_INDENT=0
                  # if [[ "$HOME/.config/zsh/.p10k.zsh" ]]; then source "$HOME/.config/zsh/.p10k.zsh"; fi

                  # any-nix-shell zsh --info-right | source /dev/stdin
                  # TODO: remove escape seq
                  # eval "$(''${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config ''${ompCfg}')"

                  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
                  zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
                  zstyle ':completion:*' menu no
                  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
                ''
                # + lib.optionalString config.programs.starship.enable ''
                # 	_transient_prompt_preexec() {
                # 		_cmd_was_run=1
                # 	}
                #
                # 	zle-line-finish() {
                # 		if [[ -n "$_cmd_was_run" ]]; then
                # 		PROMPT="$(starship module character) "
                # 		unset _cmd_was_run
                # 		fi
                # 	}
                #
                # 	add-zsh-hook preexec _transient_prompt_preexec
                # 	zle -N zle-line-finish
                # ''
                ;
              autosuggestion = {
                enable = true;
                strategy = [
                  "history"
                  "completion"
                ];
              };
              enableCompletion = true;
              envExtra = "fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)";

              completionInit = " autoload -Uz compinit && compinit -C";
              enableVteIntegration = true;
              autocd = true;
              defaultKeymap = "emacs";
              # dirHashes = {
              #	movs = "/run/media/${config.home.username}/4545627b-bf85-4556-8d34-239e9301f743/unseen";
              #	games = "/run/media/${config.home.username}/88a877a8-0f92-4cc2-b1e7-a121dde16fcb/files";
              # };
              dotDir = "${config.xdg.configHome}/zsh";
              history = {
                # expireDuplicatesFirst = true;
                extended = false;
                ignoreAllDups = true;
                ignorePatterns = [
                  "bash"
                  "btop"
                  "clear"
                  "killall *"
                  "nh *"
                  "pkill *"
                  "rm *"
                  "zsh"
                ];
                ignoreSpace = true;
                share = true;
              };
              historySubstringSearch = {
                enable = true;
              };
              oh-my-zsh = {
                enable = false;
                # extraConfig = ''
                #     zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github
                # '';
                plugins = [
                  "git"
                  "sudo"
                ];
                # theme = "";
              };
              plugins = [
                rec {
                  name = "fast-syntax-highlighting";
                  src = pkgs.zsh-fast-syntax-highlighting;
                  file = "share/zsh/plugins/${name}/${name}.plugin.zsh";
                }
                rec {
                  name = "fzf-tab";
                  src = pkgs.zsh-fzf-tab;
                  file = "share/${name}/${name}.plugin.zsh";
                }
                # {
                #	name = "powerlevel10k";
                #	src = inputs.powerlevel10k;
                #	file = "powerlevel10k.zsh-theme";
                # }
              ];
              zprof.enable = false;
            };
          })
        ];

        config.desktop.apps.zsh.enable = lib.mkDefault true;
      }
    )
  ];
}
