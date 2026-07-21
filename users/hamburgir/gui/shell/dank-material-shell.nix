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
		};
	};
}
