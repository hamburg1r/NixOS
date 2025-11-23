{
	lib,
	...
}: {
    programs = {
        gh = {
            gitCredentialHelper.enable = lib.mkDefault true;
            settings = {
                git_protocol = lib.mkDefault "ssh";
                editor = lib.mkDefault "nvim";
            };
        };
        git = {
            # diff-so-fancy.enable = lib.mkDefault true;
            ignores = lib.mkDefault [ "*.tmp" "*.temp" "tmp.*" "temp.*" ];
            settings = {
                init.defaultBranch = "main";
            };
        };
        delta.enable = lib.mkDefault true;
        lazygit.enable = lib.mkDefault true;
    };
}
