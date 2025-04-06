{
	lib,
	pkgs,
	...
}: with lib; {
	options.userTheme.cursors = {
		name = mkOption {
			type = types.str;
			description = "The name of the cursor theme.";
			example = "catppuccin-mocha-blue-cursors";
		};

		package = mkOption {
			type = types.package;
			description = "The cursor package to use.";
			example = "pkgs.catppuccin-cursors.mochaBlue";
		};

		size = mkOption {
			type = types.int;
			default = 32;
			description = "Cursor size.";
			example = 32;
		};
	};

	config = { };
}
