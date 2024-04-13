{ inputs, pkgs, ... }: {
	home.packages = with pkgs; [
		discord
		vesktop
	];
    programs.webcord = {
        enable = false;
        themes = let
            catppuccin = pkgs.fetchFromGitHub {
                owner = "catppuccin";
                repo = "discord";
                rev = "159aac939d8c18da2e184c6581f5e13896e11697";
                sha256 = "sha256-cWpog52Ft4hqGh8sMWhiLUQp/XXipOPnSTG6LwUAGGA=";
            };
        in {
            CatpuccinMocha = "${catppuccin}/themes/mocha.theme.css";
        };
    };
}
