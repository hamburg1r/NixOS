{
    pkgs,
    ...
}: {
    home.packages = with pkgs; [
        antigravity-ide
        antigravity-cli
        omniroute
        opencode
    ];
}
