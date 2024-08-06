{
	inputs,
	...
}: {
	services.greetd = {
		enable = false;
		settings = {
		  default_session = {
			command = "${inputs}/bin/greeter";
		    # command = "${pkgs.zsh}/bin/zsh";
		    # command = "${pkgs.python3Packages.ipython}/bin/ipython";
		    # command = "${pkgs.greetd.greetd}/bin/agreety --cmd sway";
		  };
		};
	};
}
