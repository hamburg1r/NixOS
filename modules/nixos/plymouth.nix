{
	config,
	pkgs,
	lib,
	...
}: let
	cfg = config.custom.plymouth;
in {
	options = {
		custom = {
			plymouth = {
				enable = lib.mkEnableOption "plymouth";
				theme = {
					name = lib.mkOption {
						default = null;
						type = lib.types.nullOr lib.types.str;
						description = "Theme name";
					};
					package = lib.mkOption {
						default = pkgs.adi1090x-plymouth-themes.override {
							selected_themes = [ cfg.theme.name ];
						};
					};
				};
			};
		};
	};
	config.boot = lib.mkIf cfg.enable {
		plymouth = {
			enable = true;
			theme = cfg.theme.name;
			themePackages = [
				cfg.theme.package
			];
		};
		consoleLogLevel = 0;
		initrd.verbose = false;
		kernelParams = [
			"quiet"
			"splash"
			"boot.shell_on_fail"
			"loglevel=3"
			"rd.systemd.show_status=false"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
		];

		# ----- nixos wiki suggests this -----
		# # Hide the OS choice for bootloaders.
		# # It's still possible to open the bootloader list by pressing any key
		# # It will just not appear on screen unless a key is pressed
		# loader.timeout = 0;
	};
}
