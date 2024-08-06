{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		# grim
		wayshot
		slurp
		swappy
		# satty
		(writeShellScriptBin "rofi" ''
		if [ "$XDG_SESSION_TYPE" == "wayland" ]
		then
			${rofi-wayland}/bin/rofi $@
		else
			${rofi}/bin/rofi $@
		fi
		'')
		qbittorrent
	];
	programs.zathura.enable = true;
}
