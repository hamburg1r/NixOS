{ ... }: {
    programs = {
        gh = {
            gitCredentialHelper.enable = true;
            settings = {
                git_protocol = "ssh";
                editor = "nvim";
            };
        };
        git = {
            #delta.enable = true;
            diff-so-fancy.enable = true;
            ignores = [ "*.tmp" "*.temp" "tmp.*" "temp.*" ];
        };
        lazygit.enable = true;
    };
}
