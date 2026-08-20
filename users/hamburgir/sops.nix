{
	config,
	pkgs,
	...
}: let
	githubToken = "users/hamburgir/github_token";
in {
	sops = {
		age = {
			keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
			sshKeyPaths = [ ];
		};
		gnupg.sshKeyPaths = [ ];

		secrets.${githubToken} = {
			sopsFile = ../../secrets/users/hamburgir/github_token;
			format = "binary";
		};

		templates."nix-access-tokens.conf".content = ''
			access-tokens = github.com=${config.sops.placeholder.${githubToken}}
		'';
	};

	nix = {
		package = pkgs.nix;
		extraOptions = ''
			!include ${config.sops.templates."nix-access-tokens.conf".path}
		'';
	};
}
