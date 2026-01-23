{
	config,
	lib,
	...
}: let
	cfg = config.desktop;
	programs = cfg.programs;
	keybinds = cfg.keybinds;
	capitalize = str: "${lib.strings.toUpper (builtins.substring 0 1 str)}${builtins.substring 1 (-1) str}";
	mod = key: "${capitalize cfg.modifier}+${capitalize key}";

	mkBinds = actions: lib.attrsets.listToAttrs (
		lib.mapAttrsToList (key: action: {
			name = mod key;
			value = action;
		}) actions
	);

in {
	programs.niri.settings.binds = mkBinds {
		"${keybinds.terminal}" = {
			action.spawn = [ programs.terminal ];
			repeat = false;
		};
		"${keybinds.app-launcher}" = { action.spawn = [ programs.app-launcher ]; };
	};
}
