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
            lfs.enable = true;
			settings = {
				user.name = "Hamburgir";
				user.email = "shantnuprofid@gmail.com";
			};
		};
		lazygit = {
			settings = {
				git.pagers = [
					{
						pager = "${pkgs.delta}/bin/delta --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
					}
				];
			};
		};
	};
}
