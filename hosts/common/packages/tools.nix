{
	pkgs,
	lib,
	...
}: {
	environment.systemPackages = with pkgs; [
		lz4
		unrar
		unzip
	];
	services.upower = {
		enable = lib.mkDefault true;
	};
}
