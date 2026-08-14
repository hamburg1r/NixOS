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
			"input"
		];
		openssh.authorizedKeys.keys = [
		];
		homeMode = "755";
		shell = pkgs.zsh;
	};
}
