{
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		firefox
	];
	# TODO: add setting options from/for firefox
	programs.firefox = {
		enable = false;
		profiles.hamburgir = {
			isDefault = true;
			search = {
				engines = {
					"Google" = {
						urls = [{
							template = "https://google.com";
							params = [
								{ name = "q"; value = "{searchTerms}"; }
							];
						}];

						icon = "";
						definedAlias = [ "@g" ];
					};
					"Nix Options" = {
						urls = [{
							template = "https://search.nixos.org/options";
							params = [
								{ name = "type"; value = "packages"; }
								{ name = "query"; value = "{searchTerms}"; }
							];
						}];

						icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
						definedAlias = [ "@no" ];
					};
					"Nix Packages" = {
						urls = [{
							template = "https://search.nixos.org/packages";
							params = [
								{ name = "type"; value = "packages"; }
								{ name = "query"; value = "{searchTerms}"; }
							];
						}];

						icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
						definedAlias = [ "@np" ];
					};
				};
				force = true;
			};
		};
	};
}
