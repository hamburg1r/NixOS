{
	pkgs,
	inputs,
	...
}: {
	live-server = pkgs.callPackage ./live-server { inherit inputs; };
	autosave = pkgs.callPackage ./autosave-nvim { inherit inputs; };
	tiny-code-action = pkgs.callPackage ./tiny-code-action { inherit inputs; };
}
