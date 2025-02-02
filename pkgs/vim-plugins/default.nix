{
	pkgs,
	inputs,
	...
}: {
	live-server = pkgs.callPackage ./live-server { inherit inputs; };
	autosave = pkgs.callPackage ./autosave-nvim { inherit inputs; };
}
