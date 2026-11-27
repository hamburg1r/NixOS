{...}: {
  config.dendritic.home.common = [
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

        # Restore the old home's DMS layout and preferences, including the
        # no-suspend timeouts previously applied during activation.
        xdg.configFile."dms/settings.json" = {
          source = ./dms-settings.json;
          force = true;
        };

        # DMS already wrote this from the GUI; allow HM to replace it with the declarative copy.
        xdg.configFile."dms/plugin_settings.json".force = true;

        # Dock pins live in DMS's writable session state, not settings.json.
        # Merge only the pins so wallpapers and other live session data remain writable.
        home.activation.dmsDockPins = lib.hm.dag.entryAfter ["writeBoundary"] ''
          sessionFile="$HOME/.local/state/dms/session.json"
          if [ ! -L "$sessionFile" ]; then
            mkdir -p "$(dirname "$sessionFile")"
            tmp="$(mktemp "$sessionFile.XXXXXX")"
            if [ -f "$sessionFile" ]; then
              sourceFile="$sessionFile"
            else
              printf '%s\n' '{"configVersion":8}' > "$tmp"
              sourceFile="$tmp"
            fi
            if ${lib.getExe pkgs.jq} \
              --argjson pins '["kitty","firefox","discord","com.github.th-ch.youtube-music"]' \
              '(.dockPins //= {}) | .dockPins.dock = $pins' \
              "$sourceFile" > "$tmp.updated"; then
              if [ ! -f "$sessionFile" ] || ! cmp -s "$sessionFile" "$tmp.updated"; then
                mv "$tmp.updated" "$sessionFile"
              else
                rm "$tmp.updated"
              fi
            else
              rm -f "$tmp.updated"
              echo "Could not update DMS dock pins in $sessionFile" >&2
              exit 1
            fi
            rm -f "$tmp"
          fi
        '';
      }
    )
  ];
}
