{
	lib,
	pkgs,
	...
}: {
	# TODO: move stuff to common profile(potentially?)
	programs = {
		atuin = {
			enable = false;
			settings = {
				auto_sync = true;
				update_check = false;
				sync_frequency = "10m";
				search_mode = "fuzzy";
				filter_mode = "global";
				exit_mode = "return-original";
			};
		};
		broot = {
			enable = true;
		};
		command-not-found = {
			enable = true;
		};

		bash = {
			enable = true;
		};
		zsh = let
			# ompCfg = "${config.home.homeDirectory}/.config/zsh/ompcfg.json";
			ompCfg = builtins.toFile "ompConf.json" (builtins.toString (builtins.replaceStrings [ "\\\\" ] [ "\\" ] (builtins.toJSON {
				"$schema"= "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
				version= 2;
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
								template = "\\udb80\\udda5";
							}
						];
					}
					# {
					# 	type = "prompt";
					# 	alignment = "right";
					# 	segments = [
					# 	];
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
								template = "\\uf101 ";
							}
						];
					}
					{
						type = "rprompt";
						# alignment = "right";
						segments = [
							{
								template = "\\udb84\\udd05 nix-{{ .Type }}";
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
								template = " \\uf520 {{ .FormattedMs }}";
							}
						];
					}
				];
				secondary_prompt = {
					foreground_templates = [
						"{{if gt .Code 0}}red{{end}}"
						"{{if eq .Code 0}}blue{{end}}"
					];
					template = "\\uf105 ";
				};
				transient_prompt = {
					foreground_templates = [
						"{{if gt .Code 0}}red{{end}}"
						"{{if eq .Code 0}}blue{{end}}"
					];
					template = "\\uf101 ";
				};
			})));
		in {
			enable = true;
			initContent = ''
				eval "$(zellij setup --generate-auto-start zsh)"

				# ZLE_RPROMPT_INDENT=0
				# if [[ "$HOME/.config/zsh/.p10k.zsh" ]]; then source "$HOME/.config/zsh/.p10k.zsh"; fi

			    # any-nix-shell zsh --info-right | source /dev/stdin
				eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config '${ompCfg}')"
				bindkey '^p' history-search-backward
				bindkey '^n' history-search-forward

				zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
				zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
				zstyle ':completion:*' menu no
				zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
			'';
			autosuggestion = {
				enable = true;
				strategy = [
					"history"
					"completion"
				];
			};
			enableCompletion = true;
			completionInit = "autoload -Uz compinit && compinit -C";
			enableVteIntegration = true;
			autocd = true;
			defaultKeymap = "emacs";
			# dirHashes = {
			# 	movs = "/run/media/${config.home.username}/4545627b-bf85-4556-8d34-239e9301f743/unseen";
			# 	games = "/run/media/${config.home.username}/88a877a8-0f92-4cc2-b1e7-a121dde16fcb/files";
			# };
			dotDir = ".config/zsh";
			history = {
				# expireDuplicatesFirst = true;
				extended = true;
				ignoreDups = true;
				ignorePatterns = [
					"bash"
					"clear"
					"killall *"
					"pkill *"
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
					file = "share/zsh/site-functions/${name}.plugin.zsh";
				}
				rec {
					name = "zsh-completions";
					src = pkgs.zsh-completions;
					file = "share/zsh/site-functions/${name}.plugin.zsh";
				}
				{
					name = "fzf-tab";
					src = pkgs.zsh-fzf-tab;
					file = "share/fzf-tab/fzf-tab.plugin.zsh";
				}
				# {
				# 	name = "powerlevel10k";
				# 	src = inputs.powerlevel10k;
				# 	file = "powerlevel10k.zsh-theme";
				# }
			];
			zprof.enable = false;
		};
		fzf = {
			enable = true;
			changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
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
		starship = {
			enable = false;
			enableBashIntegration = true;
			enableZshIntegration = true;
			settings = {
				add_newline = false;
				format = pkgs.lib.concatStrings [
					# "[╭](black)" "$fill" "$nix_shell" "[╮](black)" "$line_break"
					# "│" "─"
					# "│" "─"
					# "[╰](black)" "$os" "[\\[ $directory \\]](blue)" "[─](black)" "$character" # "╯"

					"$os" "$directory" "$c" "\n"
					"$username" "$character"

					# "$username" "$directory" "$character"
				];
				right_format = pkgs.lib.concatStrings [
					# "$time" "$cmd_duration" "[╯](black)"
					"$time" "$cmd_duration" "$nix_shell"

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
					home_symbol = "󰋜";
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
	};
}
