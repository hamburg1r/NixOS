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
            delta.enable = lib.mkDefault true;
            # diff-so-fancy.enable = lib.mkDefault true;
            ignores = lib.mkDefault [ "*.tmp" "*.temp" "tmp.*" "temp.*" ];
        };
        lazygit.enable = lib.mkDefault true;
    };
}
