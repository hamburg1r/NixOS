{
	config,
	lib,
	...
}: {
	programs.niri.settings.spawn-at-startup =
		(lib.optionals config.programs.ignis-desktop.enable [
			{ argv = ["ignis-desktop"]; }
		]) ++ (lib.optionals config.programs.noctalia-shell.enable [
			{ argv = ["noctalia-shell"]; }
		]);
}
