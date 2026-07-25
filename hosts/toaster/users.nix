{
	pkgs,
	...
}: {
	users.users.hamburgir = {
		isNormalUser = true;
		description = "Shantnu Biswas";
		extraGroups = [
			# "adbusers"
			"networkmanager"
			"wheel"
			"storage"
			"inputs"
		];
		openssh.authorizedKeys.keys = [
		];
		homeMode = "755";
		shell = pkgs.zsh;
	};
}
