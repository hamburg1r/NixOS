{
	config,
	lib,
	pkgs,
	...
}: with lib; {
	config = mkIf config.programs.lf.enable {
		programs.lf.commands = {
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

			dragon-out = ''%files=(''${fx}) && ${pkgs.dragon-drop}/bin/xdragon -a -x "''${files[@]}"'';

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
					${pkgs.trash-cli}/bin/trash-put "''${files[@]}"
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
	};
}
