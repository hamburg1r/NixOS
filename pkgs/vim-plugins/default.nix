{
	pkgs,
	...
}: {
	live-server = pkgs.callPackage ./live-server {};
}
