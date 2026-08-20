{
	inputs,
	config,
	lib,
	pkgs,
	...
}: {
	imports = [
		inputs.dms.homeModules.dank-material-shell
		inputs.dms-plugin-registry.homeModules.default
	];

	# Bongo Cat needs libinput/evtest on PATH (HM has no NixOS-style services.path).
	systemd.user.services.dms.Service.Environment = lib.mkAfter [
		"PATH=${lib.makeBinPath [
			pkgs.libinput
			pkgs.evtest
            pkgs.gpu-screen-recorder
		]}:${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
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
