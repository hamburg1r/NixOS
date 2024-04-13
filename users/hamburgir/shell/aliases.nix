{
	pkgs,
	...
}: {
	home.shellAliases = {
		ls = "${pkgs.eza}/bin/eza";
		cat = "${pkgs.bat}/bin/bat";
	};
}
