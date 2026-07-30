{
	inputs,
	...
}: {
	imports = [
		inputs.dms.homeModules.dank-material-shell
		inputs.dms-plugin-registry.homeModules.default
	];

	programs = {
		dank-material-shell = {
			enable = true;
			systemd = {
				enable = true;
				restartIfChanged = true;
			};

			plugins = {
				bongoCat = {
					enable = true;
					settings = {
						selectedDevicePath = "all";
					};
				};
				dankBatteryAlerts = {
					enable = true;
					settings = {
						criticalThreshold = 15;
						warningThreshold = 25;
					};
				};
				dankKDEConnect.enable = true;
				dankPomodoroTimer.enable = true;
				discordVoice.enable = true;
				emojiLauncher = {
					enable = true;
					settings = {
						pasteOnSelect = false;
					};
				};
				niriWindows.enable = true;
				quickCapture = {
					enable = true;
					settings = {
						postNotification = "toast";
					};
				};
			};
		};
	};

	# DMS already wrote this from the GUI; allow HM to replace it with the declarative copy.
	xdg.configFile."DankMaterialShell/plugin_settings.json".force = true;
}
