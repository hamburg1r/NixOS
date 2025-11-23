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
	];
	programs.zathura.enable = true;
}
