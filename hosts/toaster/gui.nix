{
	inputs,
	outputs,
	pkgs,
	lib,
	config,
	...
}: {
	# Enable the X11 windowing system.

	wallpaper.sddm = {
		dir = "your_name";
		file = "VillageComet.jpg";
	};

	services.xserver.desktopManager = {
		xfce.enable = false;
		gnome.enable = false;
	};
	services.desktopManager.plasma6.enable = true;


	services.xserver.windowManager = {
		qtile.enable = false;
		i3.enable = true;
		herbstluftwm.enable = false;
		awesome = {
			enable = false;
			luaModules = with pkgs.luaPackages;[
				luarocks
				luadbi-mysql
			];
		};
	};

	services.xserver.excludePackages = [ pkgs.xterm ];

	programs.sway.enable = true;

	environment.systemPackages = lib.mkIf config.services.desktopManager.plasma6.enable [pkgs.kdePackages.sddm-kcm];
	services.displayManager = {
		# gdm.enable = false;
		sddm = {
			enable = true;
			# theme = "catppuccin-mocha";
		};
		# lightdm.enable = false;
	};

	# Configure keymap in X11
	services.xserver = {
		enable = true;
		xkb = {
			layout = "us";
			variant = "";
		};
	};
	services.gnome.gnome-keyring.enable = true;
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
	# xdg.portal = {
	# 	enable = true;
	# 	extraPortals = with pkgs; [
	# 		xdg-desktop-portal-wlr
	# 		xdg-desktop-portal-gtk
	# 		xdg-desktop-portal-hyprland
	# 	];
	# 	# gtkUsePortal=true;
	# };

	security.polkit.enable = true;
	systemd = {
		user.services.polkit-gnome-authentication-agent-1 = {
			description = "polkit-gnome-authentication-agent-1";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;
}
