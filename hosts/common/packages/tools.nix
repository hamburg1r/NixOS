{
	pkgs,
	lib,
	...
}: {
	environment.systemPackages = with pkgs; [
		lz4
		unrar
		unzip
		ripgrep
		fd
	];
	services.upower = {
		enable = lib.mkDefault true;
	};
}
