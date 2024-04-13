{ pkgs, ... }: {
	home.packages = with pkgs; [
		# grim
		wayshot
		slurp
		swappy
		# satty
	];
}
