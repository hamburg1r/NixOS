{
	lib,
	...
}: {
	programs = {
		btop = {
			enable = lib.mkDefault true;
		};
		home-manager = {
			enable = lib.mkDefault true;
		};

		bat = {
			enable = lib.mkDefault true;
			config = {
				tabs = lib.mkDefault "4";
			};
		};
		less = {
			enable = lib.mkDefault true;
			config = lib.mkDefault ''
				i quit
			'';
		};
	};
}
