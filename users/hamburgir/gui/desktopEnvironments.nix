{
	inputs,
	pkgs,
	...
}: {
	wayland.windowManager.hyprland = {
		enable = true;
	};
	programs.niri = {
		enable = true;
		package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
	};
}
