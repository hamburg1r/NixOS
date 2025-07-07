{
	pkgs,
	...
}: {
	home.packages = with pkgs; with xfce; [
		nemo
		# thunar
		ristretto
		spotify
		ytmdesktop
	];
}
