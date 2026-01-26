{
	config,
	lib,
	...
}:

with lib;
let
	cfg = config.programs.niri.settings;
in {
	options.programs.niri.customSettings = {
		movement = {
			wrapColumns = mkOption {
				type = types.bool;
				default = true;
				description = "Whether to loop column movement (e.g., focus-column-right-or-first).";
			};
			wrapWindowsAndWorkspaces = mkOption {
				type = types.bool;
				default = true;
				description = "Whether to loop window/workspace movement (e.g., focus-window-or-workspace-down).";
			};
		};
	};
}
