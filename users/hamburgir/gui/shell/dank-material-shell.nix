{...}: {
  config.dendritic.home.hamburgir = [
    (
      {
        inputs,
        config,
        lib,
        pkgs,
        ...
      }: {
        imports = [inputs.dms.homeModules.dank-material-shell inputs.dms-plugin-registry.homeModules.default];

        # Bongo Cat needs libinput/evtest on PATH (HM has no NixOS-style services.path).
        systemd.user.services.dms.Service.Environment = lib.mkAfter [
          "PATH=${lib.makeBinPath [
            pkgs.libinput
            pkgs.evtest
            pkgs.gpu-screen-recorder
          ]}:${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
        ];

        programs = {
          dank-material-shell = {
            enable = true;
            systemd = {
              enable = true;
              restartIfChanged = true;
            };

            plugins = {
              bongoCat = {
                enable = true;
                settings = {
                  selectedDevicePath = "all";
                };
              };
              # dankBatteryAlerts = {
              # 	enable = true;
              # 	settings = {
              # 		criticalThreshold = 15;
              # 		warningThreshold = 25;
              # 	};
              # };
              # dankKDEConnect.enable = true;
              dankPomodoroTimer.enable = true;
              # discordVoice.enable = true;
              emojiLauncher = {
                enable = true;
                settings = {
                  pasteOnSelect = false;
                };
              };
              niriWindows.enable = true;
              # quickCapture = {
              # 	enable = true;
              # 	settings = {
              # 		postNotification = "toast";
              # 	};
              # };
            };
          };
        };

        # DMS already wrote this from the GUI; allow HM to replace it with the declarative copy.
        xdg.configFile."dms/plugin_settings.json".force = true;

        home.activation.dmsSleepSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
          dmsSettings="$HOME/.config/DankMaterialShell/settings.json"
          if [ -f "$dmsSettings" ] && [ ! -L "$dmsSettings" ]; then
            tmp="$(mktemp)"
            if ${pkgs.jq}/bin/jq '
              .acMonitorTimeout = 600
              | .acLockTimeout = 300
              | .acSuspendTimeout = 3600
              | .acSuspendBehavior = 0
              | .acPostLockMonitorTimeout = 0
              | .batteryMonitorTimeout = 180
              | .batteryLockTimeout = 120
              | .batterySuspendTimeout = 900
              | .batterySuspendBehavior = 0
              | .batteryPostLockMonitorTimeout = 0
              | .loginctlLockIntegration = true
              | .lockBeforeSuspend = true
            ' "$dmsSettings" > "$tmp"; then
              mv "$tmp" "$dmsSettings"
            else
              rm -f "$tmp"
            fi
          fi
        '';
      }
    )
  ];
}
