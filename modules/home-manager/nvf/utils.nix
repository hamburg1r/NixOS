{
	...
}: {
	vim = {
		autopairs = {
			nvim-autopairs.enable = true;
		};
		binds.whichKey = {
			enable = true;
			register = {};
			# setupOpts.preset = "modern"; # "classic" "helix"
		};
		comments.comment-nvim = {
			enable = true;
			setupOpts = {
				padding = true;
				sticky = true;
				mappings = {
					basic = true;
					extra = true;
				};
			};
		};
	};
}
