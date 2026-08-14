{
	config,
	lib,
	pkgs,
	...
}: with lib; {
	config = mkIf config.programs.lf.enable {
		programs.lf.extraConfig = let
			previewer = pkgs.writeShellScriptBin "pv.sh" ''
				#!/bin/sh
				draw() {
					${pkgs.kitty}/bin/kitten icat --stdin no --transfer-mode memory --place "''${w}x''${h}@''${x}x''${y}" "$1" </dev/null >/dev/tty
					exit 1
				}

				file="$1"
				w="$2"
				h="$3"
				x="$4"
				y="$5"

				case "$(file -Lb --mime-type "$file")" in
				image/*)
					draw "$file"
					;;
				video/*)
					# vidthumb is from here:
					# https://raw.githubusercontent.com/duganchen/kitty-pistol-previewer/main/vidthumb
					draw "$(vidthumb "$file")"
					;;
				esac

				${pkgs.pistol}/bin/pistol "$file"
			'';
			cleaner = pkgs.writeShellScriptBin "clean.sh" ''
				${pkgs.kitty}/bin/kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
			'';
		in ''
			set cleaner ${cleaner}/bin/clean.sh
			set previewer ${previewer}/bin/pv.sh
		'';

		programs.pistol = {
			enable = true;
			associations = let
				batcmd = (args: "bat --tabs 4 --color=always -pp ${args} %pistol-filename%");
			in [
				{ mime = "application/json"; command = batcmd "--language=json"; }
				{ mime = "application/javascript"; command = batcmd ""; }
				{ mime = "text/*"; command = batcmd ""; }
				{ mime = "image/jpeg|image/png|image/gif"; command = "kitty +kitten icat --stdin no --transfer-mode file --place=%pistol-extra0%x%pistol-extra1%@%pistol-extra2%x%pistol-extra3% %pistol-filename%"; }
				{ mime = "image/svg+xml"; command = "${pkgs.librsvg}/bin/rsvg-convert -w %pistol-extra0% -h %pistol-extra1% %pistol-filename%"; }
			];
		};
	};
}
