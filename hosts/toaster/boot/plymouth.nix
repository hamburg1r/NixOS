{
	pkgs,
	...
}: {
	boot.plymouth = {
		enable = true;
		theme = "owl";
		# logo = ;
		themePackages = [ (pkgs.adi1090x-plymouth-themes.override { selected_themes = [ "owl" ]; }) ];
		# extraConfig = ;
	};
}
