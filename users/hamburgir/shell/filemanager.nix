{
	pkgs,
	config,
	inputs,
	...
}: {
	# TODO: move stuff to common profile(potentially?)
	xdg.configFile."lf/icons".source = ./lf-icons;

	home.packages = with pkgs; [
		inputs.superfile.packages.x86_64-linux.default
	];
	programs = {
		yazi = {
			enable = false;
		};
		ranger = {
			enable = false;
		};
		nnn = {
			enable = false;
			package = pkgs.nnn.override ({ withNerdIcons = true; });
			# bookmarks = ;
			# extraPackages = [  ];
			# plugins = {
			#     src = ;
			#     mappings = ;
			# };
		};

		lf = {
			enable = true;
			commands = {
				cut-add = ''
				%{{
					newline=$'\n'
					sed -i '1s/.*/move/' "$XDG_DATA_HOME/lf/files"
					echo "$fx" >> "$XDG_DATA_HOME/lf/files"
					lf -remote "send $id unselect''${newline}send $id sync"
				}}
				'';
				cut-remove = ''
				%{{
					newline=$'\n'
					sed -i '1s/.*/move/' "$XDG_DATA_HOME/lf/files"
					while read -r file; do
						sed -i "\|$file|d" "$XDG_DATA_HOME/lf/files"
					done <<< "$fx"
					lf -remote "send $id unselect''${newline}send $id sync"
				}}
				'';
				cut-toggle = ''
				%{{
					newline=$'\n'
					files=$(comm --output-delimiter="" -3 \
						<(tail -n +2 "$XDG_DATA_HOME/lf/files" | sort) \
						<(echo "$fx" | sort) | tr -d '\0')
					printf "move\n$files" > "$XDG_DATA_HOME/lf/files"
					lf -remote "send $id unselect''${newline}send $id sync"
				}}
				'';

				dragon-out = ''%files=(''${fx}) && ${pkgs.xdragon}/bin/xdragon -a -x ''${files[@]}'';

				editor-open = ''$$EDITOR $f'';

				follow_link = ''
				%{{
					lf -remote "send ''${id} select '$(readlink $f)'"
				}}
				'';

				link = ''
				%{{
					set -- $(cat ~/.local/share/lf/files)
					mode="$1"
					shift
					if [ "$#" -lt 1 ]; then
						lf -remote "send $id echo no files to link"
						exit 0
					fi
					case "$mode" in
						# symbolically copy mode is indicating a soft link
						copy) ln -s -t . -- "$@";;
						# while a move mode is indicating a hard link
						move) ln -t . -- "$@";;
					esac
				}}
				'';
				relative-link = ''
				%{{
					set -- $(cat ~/.local/share/lf/files)
					mode="$1"
					shift
					if [ "$#" -lt 1 ]; then
						lf -remote "send $id echo no files to link"
						exit 0
					fi
					case "$mode" in
						# symbolically copy mode is indicating a soft link
						copy) ln -sr -t . -- "$@";;
						# while a move mode is indicating a hard link
						move) ln -t . -- "$@";;
					esac
				}}
				'';

				mkdir = "%mkdir -p $@";
				move-parent = ''
				&{{
					dironly="setlocal '$(dirname "$PWD")' dironly"
					lf -remote "send $id :updir; $dironly true; $1; $dironly false; open"
				}}
				'';

				on-redraw = ''
				%{{
					if [ "$lf_width" -le 78 ]; then
						lf -remote "send $id set ratios \"1:2\""
					elif [ "$lf_width" -le 160 ]; then
						lf -remote "send $id set ratios \"1:2:3\""
					else
						lf -remote "send $id set ratios \"1:1:3:5\""
					fi
				}}
				'';

				yank-dirname = ''$dirname -- "$f" | head -c-1 | wl-copy'';
				# yank-path = ''$printf '%s' "$fx" | wl-copy'';
				yank-path = ''$wl-copy "$fx"'';
				yank-basename = ''$basename -a -- $fx | head -c-1 | wl-copy'';
				yank-basename-without-extension = ''
				''${{
					echo "$fx" |
					xargs -r -d '\n' basename -a |
					awk -e '{
						for (i=length($0); i > 0; i--) {
							if (substr($0, i, 1) == ".") {
								if (i == 1) print $0
								else print substr($0, 0, i-1)
								break
							}
						}

						if (i == 0)
						print $0
					}' |
					if [ -n "$fs" ]; then cat; else tr -d '\n'; fi |
					wl-copy
				}}'';
			};
			keybindings = {
				"~" = "toggle";

				"." = "set hidden!";

				"]" = "move-parent down";
				"[" = "move-parent up";

				d = "";
				dd = "cut";
				dD = "delete";
				do = "dragon-out";
				dm = "$bashmount";

				y = "";
				yy = "copy";
				ya = "cut-add";
				yr = "cut-remove";
				yt = "cut-toggle";

				yd = "yank-dirname";
				yp = "yank-path";
				yn = "yank-basename";
				"y." = "yank-basename-without-extension";

				p = "";
				pp = "paste";
				pl = "link";
				pr = "relative-link";

				gt = "cd /tmp";
				"g/" = "cd /";
				gr = "cd /run";
				gd = "cd ~/repo/NixOS";
				gL = "follow_link";

				c = "";
				cc = "clear";
				cd = "push :mkdir<space>";
			};
			extraConfig = let
				previewer = pkgs.writeShellScriptBin "pv.sh" ''
					file=$1
					w=$2
					h=$3
					x=$4
					y=$5
					
					if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
						${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
						exit 1
					fi
					
					${pkgs.pistol}/bin/pistol "$file"
				'';
				cleaner = pkgs.writeShellScriptBin "clean.sh" ''
					${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
				'';
			in ''
				set cleaner ${cleaner}/bin/clean.sh
				set previewer ${previewer}/bin/pv.sh
			'';
			settings = {
				preview = true;
				# hidden = true;
				drawbox = true;
				icons = true;
				ignorecase = true;
				period = 1;
				# ratios = [1 2 3 5];
				tabstop = 4;
				# on-quit
			};
		};
		pistol = {
			enable = config.programs.lf.enable;
			associations = let
				batcmd = (args: "bat --tabs 4 --color=always -pp ${args} %pistol-filename%");
			in [
				{ mime = "application/json"; command = batcmd "--language=json";}
				{ mime = "application/javascript"; command = batcmd "";}
				{ mime = "text/*"; command = batcmd "";}
			];
		};
	};
}
