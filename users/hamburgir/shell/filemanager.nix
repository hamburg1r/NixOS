{
	pkgs,
	config,
	inputs,
	...
}: {
	# TODO: move stuff to common profile(potentially?)
	xdg.configFile."lf/icons".source = ./lf-icons;

	home.packages = with pkgs; [ ];
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
			package = (pkgs.writeShellScriptBin "lf" ''
			set -e

				if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
					${pkgs.lf}/bin/lf "$@"
				else
					[ ! -d "$HOME/.cache/lf" ] && mkdir --parents "$HOME/.cache/lf"
					${pkgs.lf}/bin/lf "$@" 3>&-
				fi
			'');
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

				trash = ''
				%{{
					# put items into array that we can count them
					files=()
					while read -r line; do files+=("$line"); done <<< "$fx"
					
					# count how many items there are
					len=''${#files[@]}
					
					# confirm trashing
					if [[ $len == 1 ]]; then
						echo -n "trash '$fx' ?"
					else
						echo -n "trash $len items?"
					fi
					echo -n " [y/N] "
					
					# read answer
					read -n 1 ans
					# make it lowercase
					ans="''${ans,,}" 
					
					echo
					
					# nuke
					if [[ $ans == y ]]; then
						${pkgs.trash-cli}/bin/trash-put $fx
						if [[ $len == 1 ]]; then
							echo "trashed '$files'"
						else
							echo "trashed $len items"
						fi
					else
						# needed to clear the bottom row
						echo
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
				dD = "trash";
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
				# previewer = pkgs.writeShellScriptBin "pv.sh" ''
				# 	file=$1
				# 	w=$2
				# 	h=$3
				# 	x=$4
				# 	y=$5
				# 	
				# 	if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
				# 		${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
				# 		# ''${pkgs.chafa}/bin/chafa -f sixel -s "$2x$3" --animate off --polite on "$1"
				# 		exit 1
				# 	else
				# 		${pkgs.pistol}/bin/pistol "$file"
				# 	fi
				# 	
				# '';
				cleaner = pkgs.writeShellScriptBin "clean.sh" ''
					${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
				'';
				# previewer = pkgs.writeShellScriptBin "previewer.sh" ''
				# 	#!/bin/sh
				#
				# 	image() {
				# 		geometry="$(($2-2))x$3"
				# 		${pkgs.chafa}/bin/chafa "$1" -f sixel -s "$geometry" --animate false
				# 	}
				#
				# 	batorcat() {
				# 		file="$1"
				# 		shift
				# 		${pkgs.bat}/bin/bat --color=always --style=plain --pager=never "$file" "$@"
				# 	}
				#
				# 	glowormdcat() {
				# 		file="$1"
				# 		shift
				# 		${pkgs.glow}/bin/glow "$file"
				# 	}
				#
				# 	CACHE="$HOME/.cache/lf/thumbnail.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}'))"
				#
				# 	case "$(printf "%s\n" "$(readlink -f "$1")" | awk '{print tolower($0)}')" in
				# 		*.tgz|*.tar.gz) ${pkgs.gnutar}/bin/tar tzf "$1" ;;
				# 		*.tar.bz2|*.tbz2) ${pkgs.gnutar}/bin/tar tjf "$1" ;;
				# 		*.tar.txz|*.txz) ${pkgs.xz}/bin/xz --list "$1" ;;
				# 		*.tar) ${pkgs.gnutar}/bin/tar tf "$1" ;;
				# 		*.zip|*.jar|*.war|*.ear|*.oxt) ${pkgs.unzip}/bin/unzip -l "$1" ;;
				# 		*.rar) ${pkgs.unrar}/bin/unrar l "$1" ;;
				# 		*.md) glowormdcat "$1";;
				# 		*.7z) ${pkgs.p7zip}/bin/7z l "$1" ;;
				# 		*.[1-8]) ${pkgs.man}/bin/man "$1" | col -b ;;
				# 		*.o) ${pkgs.binutils}/bin/nm "$1";;
				# 		*.torrent) ${pkgs.transmission}/bin/transmission-show "$1" ;;
				# 		*.iso) ${pkgs.libcdio}/bin/iso-info --no-header -l "$1" ;;
				# 		*.odt|*.ods|*.odp|*.sxw) ${pkgs.odt2txt}/bin/odt2txt "$1" ;;
				# 		*.doc) ${pkgs.catdoc}/bin/catdoc "$1" ;;
				# 		*.docx) ${pkgs.python3Packages.docx2txt}/bin/docx2txt "$1" ;;
				# 		*.xml|*.html) ${pkgs.w3m}/bin/w3m -dump "$1";;
				# 		*.xls|*.xlsx)
				# 			${pkgs.gnumeric}/bin/ssconvert --export-type=Gnumeric_stf:stf_csv "$1" "fd://1" | batorcat --language=csv
				# 			;;
				# 		*.wav|*.mp3|*.flac|*.m4a|*.wma|*.ape|*.ac3|*.og[agx]|*.spx|*.opus|*.as[fx]|*.mka)
				# 			${pkgs.exiftool}/bin/exiftool "$1"
				# 			;;
				# 		*.pdf)
				# 			[ ! -f "''${CACHE}.jpg" ] && \
				# 				${pkgs.poppler_utils}/bin/pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
				# 			image "''${CACHE}.jpg" "$2" "$3" "$4" "$5"
				# 			;;
				# 		*.epub)
				# 			[ ! -f "$CACHE" ] && \
				# 				${pkgs.epub-thumbnailer}/bin/epub-thumbnailer "$1" "$CACHE" 1024
				# 			image "$CACHE" "$2" "$3" "$4" "$5"
				# 			;;
				# 		*.cbz|*.cbr|*.cbt)
				# 			[ ! -f "$CACHE" ] && \
				# 				comicthumb "$1" "$CACHE" 1024
				# 			image "$CACHE" "$2" "$3" "$4" "$5"
				# 			;;
				# 		*.avi|*.mp4|*.wmv|*.dat|*.3gp|*.ogv|*.mkv|*.mpg|*.mpeg|*.vob|*.fl[icv]|*.m2v|*.mov|*.webm|*.ts|*.mts|*.m4v|*.r[am]|*.qt|*.divx)
				# 			[ ! -f "''${CACHE}.jpg" ] && \
				# 				${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$1" -o "''${CACHE}.jpg" -s 0 -q 5
				# 			image "''${CACHE}.jpg" "$2" "$3" "$4" "$5"
				# 			;;
				# 		*.bmp|*.jpg|*.jpeg|*.png|*.xpm|*.webp|*.tiff|*.gif|*.jfif|*.ico)
				# 			image "$1" "$2" "$3" "$4" "$5"
				# 			;;
				# 	*.svg)
				# 		[ ! -f "''${CACHE}.jpg" ] && \
				# 			${pkgs.imagemagick}/bin/convert "$1" "''${CACHE}.jpg"
				# 		image "''${CACHE}.jpg" "$2" "$3" "$4" "$5"
				# 		;;
				# 		*.ino)
				# 			batorcat --language=cpp "$1"
				# 			;;
				# 		*)
				# 			batorcat "$1"
				# 			;;
				# 	esac
				# 	exit 0
				# '';
			in
			''
				# set cleaner ${cleaner}/bin/clean.sh
				set previewer ${pkgs.pistol}/bin/pistol
			'';
			# ''
			# 	set previewer ${previewer}/bin/previewer.sh
			# '';
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
				sixel = true;
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
				{ mime = "image/jpeg|image/png|image/gif"; command = "kitty +kitten icat --silent --transfer-mode=file --align=left --place=%pistol-extra0%x%pistol-extra1%@%pistol-extra2%x%pistol-extra3%";}
				{ mime = "image/svg+xml"; command = "${pkgs.librsvg}/bin/rsvg-convert -w %pistol-extra0% -h %pistol-extra1% \"$1\""; }
			];
		};
	};
}
