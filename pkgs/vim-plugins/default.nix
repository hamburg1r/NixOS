{
	pkgs,
	inputs,
	...
}: {
	live-server = pkgs.callPackage ./live-server { inherit inputs; };
}
