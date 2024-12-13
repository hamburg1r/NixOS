{
	...
}: {
	services = {
		syncthing = {
			enable = true;
			user = "hamburgir";
			dataDir = "/home/hamburgir";
			settings = {
				devices = {
					"Realme Narzo N55" = { id = "CR5CNRG-3CZA2BC-CEG6HDJ-QOGGHIG-DUPSHZ5-K2AWGWD-XWCVB7A-7O42WAC"; };
				};
				folders = {
					"GBA ROMS" = {
						path = "/run/media/hamburgir/88a877a8-0f92-4cc2-b1e7-a121dde16fcb/files/roms/gba";
						devices = [ "Realme Narzo N55" ];
					};
					"Orgzly" = {
						path = "/home/hamburgir/orgzly";
						devices = [ "Realme Narzo N55" ];
					};
					"PSP ROMS" = {
						path = "/run/media/hamburgir/88a877a8-0f92-4cc2-b1e7-a121dde16fcb/files/roms/ppsspp/roms";
						devices = [ "Realme Narzo N55" ];
					};
					"Volatile" = {
						path = "/home/hamburgir/Documents/synced";
						devices = [ "Realme Narzo N55" ];
					};
					"GATE" = {
						path = "/home/hamburgir/Documents/GATE";
						devices = [ "Realme Narzo N55" ];
					};
					# "Documents" = {
					# 	path = "/home/hamburgir/Documents"
					# };
				};
			};
		};
	};
}
