{
	config,
	lib,
	pkgs,
	...
}: let
	cfg = config.desktop;
	programs = cfg.programs;
	keybinds = cfg.keybinds;
	capitalize = str: "${lib.strings.toUpper (builtins.substring 0 1 str)}${builtins.substring 1 (-1) str}";
	mod = key: "${capitalize cfg.modifier}+${capitalize key}";

	niriCfg = config.programs.niri.customSettings;

	mkBinds = actions: lib.attrsets.listToAttrs (
		lib.mapAttrsToList (key: action: {
			name = mod key;
			value = action;
		}) actions
	);

	# Converts [["modifiers"], ["key"]] into "Modifier+Key"
	formatKeybindKey = keybindList:
		let
			modifiers = lib.head keybindList;
			key = lib.head (lib.last keybindList);
		in lib.strings.concatStringsSep "+" (modifiers ++ [ key ]);

	genFocusColBinds = keys: direction:
		lib.foldl' (acc: key: acc // { "${key}" = { action = {
			${
				if niriCfg.movement.wrapColumns then
					if direction == "left" then "focus-column-left-or-last"
					else if direction == "right" then "focus-column-right-or-first"
					else "focus-column-${direction}"
				else "focus-column-${direction}"
			} = [];
		}; }; }) {} keys;

	genFocusWinBinds = keys: direction:
		lib.foldl' (acc: key: acc // { "${key}" = { action = {
			${
				if niriCfg.movement.wrapWindowsAndWorkspaces then
					if direction == "up" then "focus-window-or-workspace-up"
					else if direction == "down" then "focus-window-or-workspace-down"
					else "focus-window-${direction}"
				else "focus-window-${direction}"
			} = [];
		}; }; }) {} keys;

	genMoveColBinds = keys: direction:
		lib.foldl' (acc: key: acc // { "Shift+${key}" = { action = { "move-column-${direction}" = []; }; }; }) {} keys;

	genMoveWinBinds = keys: direction:
		lib.foldl' (acc: key: acc // { "Shift+${key}" = { action = {
			${
				if direction == "left" then "consume-or-expel-window-left"
				else if direction == "right" then "consume-or-expel-window-right"
				else if direction == "up" then "move-window-up-or-to-workspace-up"
				else if direction == "down" then "move-window-down-or-to-workspace-down"
				else "move-window-${direction}"
			} = [];
		}; }; }) {} keys;

	genMoveToColBinds = keys: direction:
			lib.foldl' (acc: key: acc // { "Ctrl+${key}" = { action = { "move-column-to-${direction}" = []; }; }; }) {} keys;
	
in {
	programs.niri.settings.binds = mkBinds ({
		"${formatKeybindKey keybinds.terminal}" = {
			action.spawn = programs.terminal;
			repeat = false;
		};
		"${formatKeybindKey keybinds.app-launcher}" = {
			action.spawn = programs.app-launcher;
			repeat = false;
		};
		"${formatKeybindKey keybinds.show-help}" = {
			action.show-hotkey-overlay = [];
		};
		"${formatKeybindKey keybinds.screenshot}" = {
			action.screenshot = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.fullscreen-screenshot}" = {
			action.screenshot-screen = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.window-screenshot}" = {
			action.screenshot-window = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.set-dynamic-cast-window}" = {
			action.set-dynamic-cast-window = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.set-dynamic-cast-monitor}" = {
			action.set-dynamic-cast-monitor = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.clear-dynamic-cast-target}" = {
			action.clear-dynamic-cast-target = [];
			repeat = false;
		};
		# "${formatKeybindKey keybinds.stop-cast}" = {
		# 	action.stop-cast = [];
		# 	repeat = false;
		# };
		"${formatKeybindKey keybinds.close-window}" = {
			action.close-window = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.fullscreen}" = {
			action.fullscreen-window = [];
		};
		"${formatKeybindKey keybinds.maximize}" = {
			action.maximize-window-to-edges = [];
		};
		"${formatKeybindKey keybinds.toggle-windowed-fullscreen}" = {
			action.toggle-windowed-fullscreen = [];
		};
		"${formatKeybindKey keybinds.quit}" = {
			action.quit = [];
		};
		"${formatKeybindKey keybinds.toggle-tabbed-window}" = {
			action.toggle-column-tabbed-display = [];
		};
		"${formatKeybindKey keybinds.column-size-preset-next}" = {
			action.switch-preset-column-width = [];
		};
		"${formatKeybindKey keybinds.column-size-preset-back}" = {
			action.switch-preset-column-width-back = [];
		};
		"${formatKeybindKey keybinds.window-width-preset-next}" = {
			action.switch-preset-window-height = [];
		};
		"${formatKeybindKey keybinds.window-width-preset-back}" = {
			action.switch-preset-window-height-back = [];
		};
		"${formatKeybindKey keybinds.window-height-preset-next}" = {
			action.switch-preset-window-height = [];
		};
		"${formatKeybindKey keybinds.window-height-preset-back}" = {
			action.switch-preset-window-height-back = [];
		};
		"${formatKeybindKey keybinds.toggle-floating}" = {
			action.toggle-window-floating = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.toggle-focus-floating}" = {
			action.switch-focus-between-floating-and-tiling = [];
		};
		"${formatKeybindKey keybinds.toggle-workspace-overview}" = {
			action.toggle-overview = [];
			repeat = false;
		};
		"${formatKeybindKey keybinds.fake-maximize}" = {
			action.maximize-column = [];
		};
		"${formatKeybindKey keybinds.center-visible-columns}" = {
			action.center-visible-columns = [];
		};
		"${formatKeybindKey keybinds.center-column}" = {
			action.center-column = [];
		};
	} // (genFocusColBinds keybinds.movement.left "left")
	// (genFocusColBinds keybinds.movement.right "right")
	// (genFocusWinBinds keybinds.movement.up "up")
	// (genFocusWinBinds keybinds.movement.down "down")
	// (genMoveWinBinds keybinds.movement.left "left")
	// (genMoveWinBinds keybinds.movement.right "right")
	// (genMoveWinBinds keybinds.movement.up "up")
	// (genMoveWinBinds keybinds.movement.down "down")
	// (genFocusColBinds keybinds.movement.first "first")
	// (genFocusColBinds keybinds.movement.last "last")
	// (genMoveToColBinds keybinds.movement.first "first")
	// (genMoveToColBinds keybinds.movement.last "last")
	) // {
		"${formatKeybindKey keybinds.no-mod.speaker-volume-up}" = { allow-when-locked = true; action.spawn = config.desktop.actions.volume-up; };
		"${formatKeybindKey keybinds.no-mod.speaker-volume-down}" = { allow-when-locked = true; action.spawn = config.desktop.actions.volume-down; };
		"${formatKeybindKey keybinds.no-mod.speaker-mute}" = { allow-when-locked = true; action.spawn = config.desktop.actions.volume-mute; };
		"${formatKeybindKey keybinds.no-mod.mic-volume-up}" = { allow-when-locked = true; action.spawn = config.desktop.actions.mic-volume-up; };
		"${formatKeybindKey keybinds.no-mod.mic-volume-down}" = { allow-when-locked = true; action.spawn = config.desktop.actions.mic-volume-down; };
		"${formatKeybindKey keybinds.no-mod.mic-mute}" = { allow-when-locked = true; action.spawn = config.desktop.actions.mic-mute; };

		"${formatKeybindKey keybinds.no-mod.mpiris-play-pause}" = { allow-when-locked = true; action.spawn = config.desktop.actions.mpiris-play-pause; };
		"${formatKeybindKey keybinds.no-mod.mpiris-stop}" = { allow-when-locked = true; action.spawn = config.desktop.actions.mpiris-stop; };
		"${formatKeybindKey keybinds.no-mod.mpiris-previous}" = { allow-when-locked = true; action.spawn = config.desktop.actions.mpiris-previous; };
		"${formatKeybindKey keybinds.no-mod.mpiris-next}" = { allow-when-locked = true; action.spawn = config.desktop.actions.mpiris-next; };

		"${formatKeybindKey keybinds.no-mod.brightness-up}" = { allow-when-locked = true; action.spawn = config.desktop.actions.brightness-up; };
		"${formatKeybindKey keybinds.no-mod.brightness-down}" = { allow-when-locked = true; action.spawn = config.desktop.actions.brightness-down; };
	};
	# 	binds = {
	# 	"Super+Alt+L" = { hotkey-overlay.title = "Lock the Screen: swaylock"; action.spawn = [ "swaylock" ]; };
	# 	"Super+Alt+S" = { allow-when-locked = true; hotkey-overlay.hidden = true; action.spawn-sh = "pkill orca || exec orca"; };
	#
	# 	"XF86AudioRaiseVolume" = { allow-when-locked = true; action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; };
	# 	"XF86AudioLowerVolume" = { allow-when-locked = true; action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; };
	# 	"XF86AudioMute" = { allow-when-locked = true; action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; };
	# 	"XF86AudioMicMute" = { allow-when-locked = true; action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; };
	#
	# 	"XF86AudioPlay" = { allow-when-locked = true; action.spawn-sh = "playerctl play-pause"; };
	# 	"XF86AudioStop" = { allow-when-locked = true; action.spawn-sh = "playerctl stop"; };
	# 	"XF86AudioPrev" = { allow-when-locked = true; action.spawn-sh = "playerctl previous"; };
	# 	"XF86AudioNext" = { allow-when-locked = true; action.spawn-sh = "playerctl next"; };
	#
	# 	"XF86MonBrightnessUp" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ]; };
	# 	"XF86MonBrightnessDown" = { allow-when-locked = true; action.spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ]; };
	#
	# 	"Mod+O" = { repeat = false; action.toggle-overview = []; };
	#
	# 	"Mod+WheelScrollDown" = { cooldown-ms = 150; action.focus-workspace-down = []; };
	# 	"Mod+WheelScrollUp" = { cooldown-ms = 150; action.focus-workspace-up = []; };
	# 	"Mod+Ctrl+WheelScrollDown" = { cooldown-ms = 150; action.move-column-to-workspace-down = []; };
	# 	"Mod+Ctrl+WheelScrollUp" = { cooldown-ms = 150; action.move-column-to-workspace-up = []; };
	#
	# 	"Mod+1" = { action.focus-workspace = 1; };
	# 	"Mod+2" = { action.focus-workspace = 2; };
	# 	"Mod+3" = { action.focus-workspace = 3; };
	# 	"Mod+4" = { action.focus-workspace = 4; };
	# 	"Mod+5" = { action.focus-workspace = 5; };
	# 	"Mod+6" = { action.focus-workspace = 6; };
	# 	"Mod+7" = { action.focus-workspace = 7; };
	# 	"Mod+8" = { action.focus-workspace = 8; };
	# 	"Mod+9" = { action.focus-workspace = 9; };
	# 	"Mod+Ctrl+1" = { action.move-column-to-workspace = 1; };
	# 	"Mod+Ctrl+2" = { action.move-column-to-workspace = 2; };
	# 	"Mod+Ctrl+3" = { action.move-column-to-workspace = 3; };
	# 	"Mod+Ctrl+4" = { action.move-column-to-workspace = 4; };
	# 	"Mod+Ctrl+5" = { action.move-column-to-workspace = 5; };
	# 	"Mod+Ctrl+6" = { action.move-column-to-workspace = 6; };
	# 	"Mod+Ctrl+7" = { action.move-column-to-workspace = 7; };
	# 	"Mod+Ctrl+8" = { action.move-column-to-workspace = 8; };
	# 	"Mod+Ctrl+9" = { action.move-column-to-workspace = 9; };
	#
	# 	"Mod+BracketLeft" = { action.consume-or-expel-window-left = []; };
	# 	"Mod+BracketRight" = { action.consume-or-expel-window-right = []; };
	#
	# 	"Mod+R" = { action.switch-preset-column-width = []; };
	# 	"Mod+Shift+R" = { action.switch-preset-window-height = []; };
	# 	"Mod+Ctrl+R" = { action.reset-window-height = []; };
	#
	# 	"Mod+M" = { action.maximize-window-to-edges = []; };
	#
	# 	"Mod+Ctrl+F" = { action.expand-column-to-available-width = []; };
	#
	# 	"Mod+C" = { action.center-column = []; };
	# 	"Mod+Ctrl+C" = { action.center-visible-columns = []; };
	#
	# 	"Mod+Minus" = { action.set-column-width = "-10%"; };
	# 	"Mod+Equal" = { action.set-column-width = "+10%"; };
	#
	# 	"Mod+Shift+Minus" = { action.set-window-height = "-10%"; };
	# 	"Mod+Shift+Equal" = { action.set-window-height = "+10%"; };
	#
	# 	"Mod+V" = { action.toggle-window-floating = []; };
	# 	"Mod+Shift+V" = { action.switch-focus-between-floating-and-tiling = []; };
	#
	# 	"Mod+W" = { action.toggle-column-tabbed-display = []; };
	#
	# 	"Print" = { action.screenshot = []; };
	# 	"Ctrl+Print" = { action.screenshot-screen = []; };
	# 	"Alt+Print" = { action.screenshot-window = []; };
	#
	# 	"Mod+Escape" = { allow-inhibiting = false; action.toggle-keyboard-shortcuts-inhibit = []; };
	#
	# 	"Mod+Shift+E" = { action.quit = []; };
	# 	"Ctrl+Alt+Delete" = { action.quit = []; };
	#
	# 	"Mod+Shift+P" = { action.power-off-monitors = []; };
	# 	};
}
