{
	...
}: {
	imports = [
		inputs.dms.homeModules.dank-material-shell
		inputs.dms-plugin-registry.modules.default
	];

	programs = {
		dank-material-shell = {
			enable = true;
			systemd = {
				enable = true;
				restartIfChanged = true;
			};
		};
	};
}
