{
	pkgs,
	...
}: {
	programs = {
		lf.enable = true;
		yazi = {
			enable = false;
		};
		ranger = {
			enable = false;
		};
		nnn = {
			enable = false;
			package = pkgs.nnn.override ({ withNerdIcons = true; });
			# bookmarks = ;
			# extraPackages = [  ];
			# plugins = {
			#     src = ;
			#     mappings = ;
			# };
		};
	};
}
