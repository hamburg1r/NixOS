{
	...
}: {
	programs = {
		btop = {
			enable = true;
		};
		home-manager = {
			enable = true;
		};

		bat = {
			enable = true;
			config = {
				tabs = "4";
			};
		};
		less = {
			enable = true;
			keys = ''
				i quit
			'';
		};
	};
}
