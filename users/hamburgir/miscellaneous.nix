{
	pkgs,
	config,
	...
}: {
	gtk = {
		gtk3.bookmarks = let
			home = dir: "file://${config.home.homeDirectory}/${dir}";
		in [
			# "file://${config.home.homeDirectory}/"
			(home "Documents")
			(home "Downloads")
			(home "Music")
			(home "Pictures")
			(home "Templates")
			(home "Videos")
			"file:///tmp"
		];
	};

	services.network-manager-applet.enable = true;
}
