{
	pkgs,
	...
}: {
	programs = {
		gh = {
			enable = true;
		};
		git = {
			enable = true;
			userName = "Hamburgir";
			userEmail = "shantnuprofid@gmail.com";
		};
		lazygit = {
			settings = {
				git.paging.pager = "${pkgs.delta}/bin/delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
			};
		};
	};
}
