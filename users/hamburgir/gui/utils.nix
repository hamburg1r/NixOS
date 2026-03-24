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
		rofi
		qbittorrent
		peazip
	];
	programs.zathura.enable = true;
}
