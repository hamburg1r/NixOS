{
	pkgs,
	...
}: {
	programs = {
		aria2 = {
			enable = true;
		};
		bashmount = {
			enable = true;
		};
		taskwarrior = {
			enable = true;
			package = pkgs.taskwarrior3;
		};
	};
}
