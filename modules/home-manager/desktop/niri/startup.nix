{
	...
}: {
	programs.niri.settings.spawn-at-startup = [
		(lib.optionals config.programs.ignis-desktop.enable [{ argv = ["ignis-desktop"] }])
	];
}
