{
	config,
	lib,
	pkgs,
	...
}: let
	githubToken = "users/hamburgir/github_token";
	devtoApiKey = "users/hamburgir/devto_api_key";
	devtoApiKeyExport = ''
		export DEVTO_API_KEY=$(cat ${config.sops.secrets.${devtoApiKey}.path})
	'';
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

		secrets.${devtoApiKey} = {
			sopsFile = ../../secrets/users/hamburgir/devto_api_key;
			format = "binary";
		};

		templates."nix-access-tokens.conf".content = ''
			access-tokens = github.com=${config.sops.placeholder.${githubToken}}
		'';
	};

	programs.zsh.envExtra = lib.mkAfter devtoApiKeyExport;
	programs.bash.initExtra = lib.mkAfter devtoApiKeyExport;

	nix = {
		package = pkgs.nix;
		extraOptions = ''
			!include ${config.sops.templates."nix-access-tokens.conf".path}
		'';
	};
}
