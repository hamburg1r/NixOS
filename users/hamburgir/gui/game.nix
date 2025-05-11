{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		prismlauncher
		gamescope
		lutris
		steam
		steam-run
		proton-ge-bin
	];
}
