{...}: {
  config.dendritic.home.common = [
    (
      {
        pkgs,
        outputs,
        config,
        lib,
        ...
      }: let
        extensionPath = "share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}";

        fetchAddon = {
          name,
          id,
          url,
          hash,
        }:
          pkgs.runCommand "firefox-addon-${name}" {
            src = pkgs.fetchurl {
              inherit url hash;
            };
          } ''
            install -Dm644 $src "$out/${extensionPath}/${id}.xpi"
          '';

        addons = rec {
          dracula-theme = fetchAddon {
            name = "dracula-theme";
            id = "{b743f56d-1cc1-4048-8ba6-f9c2ab7aa54d}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4408557/dracula_dark_colorscheme-1.11.xpi";
            hash = "sha256-ERscK8dz+wr1YsLIWTQ+WdipDRpEYRlpf4gNF3ElPlk=";
          };

          enhancer-for-youtube = fetchAddon {
            name = "enhancer-for-youtube";
            id = "enhancerforyoutube@maximerf.addons.mozilla.org";
            url = "https://addons.mozilla.org/firefox/downloads/file/4933627/enhancer_for_youtube-2.0.136.xpi";
            hash = "sha256-OKBCCATQgiT8ROg4rsQy6UfraIsTAPQj7uy7RNMwN/o=";
          };

          instagram-video-control = fetchAddon {
            name = "instagram-video-control";
            id = "{a831defa-a6c9-4ca9-9593-9ccaf98462d9}";
            url = "https://addons.mozilla.org/firefox/downloads/file/5129669/instagram_video_control-1.9.4.xpi";
            hash = "sha256-oxGaYjvQLlEXTTUT9sDCKgj6pCo2lf1KbADugvYL13w=";
          };

          keepassxc-browser = fetchAddon {
            name = "keepassxc-browser";
            id = "keepassxc-browser@keepassxc.org";
            url = "https://addons.mozilla.org/firefox/downloads/file/5078406/keepassxc_browser-1.10.4.1.xpi";
            hash = "sha256-rkEVej8Bewdzq7ogl9WwBWJBYx0KOK021o0LJLGkCcE=";
          };

          sponsorblock = fetchAddon {
            name = "sponsorblock";
            id = "sponsorBlocker@ajay.app";
            url = "https://addons.mozilla.org/firefox/downloads/file/4897574/sponsorblock-6.1.7.xpi";
            hash = "sha256-DVDhYyxvFe4VpUPmcOHFcpdGBaXAJiKRbgjgJoA9+D8=";
          };

          ublock-origin = fetchAddon {
            name = "ublock-origin";
            id = "uBlock0@raymondhill.net";
            url = "https://addons.mozilla.org/firefox/downloads/file/5034826/ublock_origin-1.75.0.xpi";
            hash = "sha256-W3RBWGBFY3BkS9gPFhJehlsObDVrtd/PuEBpln6qUoc=";
          };

          user-agent-switcher = fetchAddon {
            name = "user-agent-switcher";
            id = "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}";
            url = "https://addons.mozilla.org/firefox/downloads/file/5081116/user_agent_string_switcher-0.7.2.xpi";
            hash = "sha256-mtDgPXN9s2Nm4W8cYQLFrFhn4056X5XwvN8A4s2gtoI=";
          };

          videospeed = fetchAddon {
            name = "videospeed";
            id = "{7be2ba16-0f1e-4d93-9ebc-5164397477a9}";
            url = "https://addons.mozilla.org/firefox/downloads/file/3756025/videospeed-0.6.3.3.xpi";
            hash = "sha256-3qIl81IN2Stas+8wUV83+9EnqhkcfrP6JUfS3q5SECo=";
          };

          vimium = fetchAddon {
            name = "vimium";
            id = "{d7742d87-e61d-4b78-b8a1-b469842139fa}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4717567/vimium_ff-2.4.2.xpi";
            hash = "sha256-Ex4qZ1gOeukSWrGXgRWeYUCfrEe0Qfwngqq3Y5bq0ZY=";
          };

          violentmonkey = fetchAddon {
            name = "violentmonkey";
            id = "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}";
            url = "https://addons.mozilla.org/firefox/downloads/file/5009389/violentmonkey-2.49.0.xpi";
            hash = "sha256-dh6moyzueMMmPRm72CHq/U6gci8Q/zWOy6JznFv/dvs=";
          };

          youtube-shorts-block = fetchAddon {
            name = "youtube-shorts-block";
            id = "{34daeb50-c2d2-4f14-886a-7160b24d66a4}";
            url = "https://addons.mozilla.org/firefox/downloads/file/4487339/youtube_shorts_block-1.5.3.xpi";
            hash = "sha256-d0iWOTvHgtsteZkqM314KWN2Y2VyPEu6tz1Tpj/rIEM=";
          };
        };

        mailtoHandler = {
          force = true;
          schemes.mailto = {
            action = 2;
            ask = true;
            handlers = [
              {
                name = "Gmail";
                uriTemplate = "https://mail.google.com/mail/?extsrc=mailto&url=%s";
              }
            ];
          };
        };

        search = {
          engines = {
            "Google" = {
              urls = [
                {
                  template = "https://google.com";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "";
              definedAlias = ["@g"];
            };
            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAlias = ["@no"];
            };
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAlias = ["@np"];
            };
          };
          force = true;
        };

        baseSettings = {
          "browser.ctrlTab.sortByRecentlyUsed" = true;
          "browser.newtabpage.enabled" = true;
          "browser.profiles.created" = true;
          "browser.profiles.enabled" = true;
          "browser.uiCustomization.state" = {
            placements = {
              "widget-overflow-fixed-list" = [
                "privatebrowsing-button"
                "sync-button"
                "firefox-view-button"
              ];
              "unified-extensions-area" = [
                "ublock0_raymondhill_net-browser-action"
                "sponsorblocker_ajay_app-browser-action"
                "enhancerforyoutube_maximerf_addons_mozilla_org-browser-action"
                "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
                "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
                "_a831defa-a6c9-4ca9-9593-9ccaf98462d9_-browser-action"
                "_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action"
                "_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action"
                "keepassxc-browser_keepassxc_org-browser-action"
                "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
              ];
              "nav-bar" = [
                "sidebar-button"
                "back-button"
                "forward-button"
                "stop-reload-button"
                "vertical-spacer"
                "urlbar-container"
                "zoom-controls"
                "search-container"
                "downloads-button"
                "fxa-toolbar-menu-button"
                "unified-extensions-button"
                "alltabs-button"
                "reset-pbm-toolbar-button"
                "ai-window-toggle"
                "smartwindow-group-tabs-button"
              ];
              "toolbar-menubar" = ["menubar-items"];
              TabsToolbar = [];
              "vertical-tabs" = ["tabbrowser-tabs"];
              PersonalToolbar = ["personal-bookmarks"];
            };
            seen = [
              "save-to-pocket-button"
              "developer-button"
              "screenshot-button"
              "reset-pbm-toolbar-button"
              "ai-window-toggle"
              "smartwindow-group-tabs-button"
              "ublock0_raymondhill_net-browser-action"
              "sponsorblocker_ajay_app-browser-action"
              "enhancerforyoutube_maximerf_addons_mozilla_org-browser-action"
              "_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"
              "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
              "_a831defa-a6c9-4ca9-9593-9ccaf98462d9_-browser-action"
              "_7be2ba16-0f1e-4d93-9ebc-5164397477a9_-browser-action"
              "_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action"
              "keepassxc-browser_keepassxc_org-browser-action"
              "_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action"
            ];
            dirtyAreaCache = [
              "unified-extensions-area"
              "TabsToolbar"
              "vertical-tabs"
              "nav-bar"
              "toolbar-menubar"
              "PersonalToolbar"
              "widget-overflow-fixed-list"
            ];
            currentVersion = 28;
            newElementCount = 9;
          };
          "dom.forms.autocomplete.formautofill" = true;
          "extensions.activeThemeID" = "nova-pine@mozilla.org";
          "extensions.autoDisableScopes" = 0;
          "sidebar.verticalTabs" = true;
          "sidebar.main.tools" = "opentabs,bookmarks,aichat,history,syncedtabs";
          "sidebar.visibility" = "hide-on-close";
          "toolkit.profiles.storeID" = "0c68fff9";
        };

        baseExtensions = with addons; [
          instagram-video-control
          keepassxc-browser
          sponsorblock
          ublock-origin
          user-agent-switcher
          vimium
          youtube-shorts-block
        ];
      in {
        imports =
          [
            (outputs.lib.mkApp pkgs {
              name = "firefox";
              install = cfg: {
                programs.firefox = {
                  enable = true;
                  package = cfg.package;
                  configPath = "${config.xdg.configHome}/mozilla/firefox";
                  profiles = {
                    hamburgir = {
                      id = 0;
                      isDefault = true;
                      path = "hamburgir";

                      settings =
                        baseSettings
                        // {
                          "accessibility.typeaheadfind.flashBar" = 1;
                          "browser.bookmarks.defaultLocation" = "toolbar";
                          "browser.bookmarks.showMobileBookmarks" = true;
                          "browser.download.deletePrivate" = true;
                          "browser.download.useDownloadDir" = false;
                          "browser.ml.chat.page.footerBadge" = false;
                          "browser.ml.chat.provider" = "https://chatgpt.com";
                          "browser.ml.chat.shortcuts" = false;
                          "browser.newtabpage.activity-stream.showSponsored" = false;
                          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
                          "browser.newtabpage.pinned" = [
                            {
                              label = "YouTube";
                              url = "https://www.youtube.com/";
                            }
                            {
                              label = "ChatGPT";
                              url = "https://chat.openai.com/";
                            }
                            {
                              label = "Reddit";
                              url = "https://www.reddit.com/";
                            }
                            {
                              label = "Discord";
                              url = "https://discord.com/app";
                            }
                            {
                              label = "WhatsApp";
                              url = "https://web.whatsapp.com/";
                            }
                            {
                              label = "Github";
                              url = "https://github.com/";
                            }
                            {
                              label = "Docs";
                              url = "https://docs.google.com/";
                            }
                          ];
                          "browser.sessionstore.resume_from_crash" = false;
                          "browser.urlbar.quicksuggest.scenario" = "history";
                          "browser.urlbar.trimHttps" = true;
                          "extensions.activeThemeID" = "{b743f56d-1cc1-4048-8ba6-f9c2ab7aa54d}";
                          "findbar.highlightAll" = true;
                          "layout.css.prefers-color-scheme.content-override" = 0;
                          "media.eme.enabled" = true;
                          "network.dns.disablePrefetch" = true;
                          "network.http.speculative-parallel-limit" = 0;
                          "network.prefetch-next" = false;
                          "privacy.clearOnShutdown_v2.formdata" = true;
                          "svg.context-properties.content.enabled" = true;
                          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                          "widget.gtk.ignore-bogus-leave-notify" = 1;
                        };

                      inherit search;
                      handlers = mailtoHandler;

                      extensions.packages =
                        baseExtensions
                        ++ (with addons; [
                          dracula-theme
                          enhancer-for-youtube
                          videospeed
                          violentmonkey
                        ]);
                    };

                    jobsearch = {
                      id = 1;
                      path = "jobsearch";

                      settings =
                        baseSettings
                        // {
                          "browser.startup.page" = 3;
                        };

                      handlers = mailtoHandler;

                      extensions.packages = baseExtensions;
                    };
                  };
                };

                home.file."${config.xdg.configHome}/mozilla/firefox/profiles.ini" = lib.mkForce {
                  text = ''
                    [General]
                    StartWithLastProfile=1
                    Version=2

                    [Profile0]
                    Default=1
                    IsRelative=1
                    Name=hamburgir
                    Path=hamburgir
                    StoreID=0c68fff9
                    ShowSelector=0

                    [Profile1]
                    Default=0
                    IsRelative=1
                    Name=jobsearch
                    Path=jobsearch
                    StoreID=0c68fff9
                    ShowSelector=0
                  '';
                };

                home.activation.firefoxProfileGroup = lib.hm.dag.entryAfter ["linkGeneration"] ''
                  profileGroupDir="${config.xdg.configHome}/mozilla/firefox/Profile Groups"
                  profileGroupDb="$profileGroupDir/0c68fff9.sqlite"
                  mkdir -p "$profileGroupDir"
                  ${pkgs.sqlite}/bin/sqlite3 "$profileGroupDb" <<'SQL' || true
                  .timeout 5000
                  CREATE TABLE IF NOT EXISTS "Profiles" (
                    id      INTEGER NOT NULL,
                    path    TEXT NOT NULL UNIQUE,
                    name    TEXT NOT NULL,
                    avatar  TEXT NOT NULL,
                    themeId TEXT NOT NULL,
                    themeFg TEXT NOT NULL,
                    themeBg TEXT NOT NULL,
                    PRIMARY KEY(id)
                  );
                  INSERT INTO "Profiles" (path, name, avatar, themeId, themeFg, themeBg)
                  SELECT 'hamburgir', 'hamburgir', 'shopping', 'default-theme@mozilla.org', 'rgb(255,255,255)', 'rgb(28,27,34)'
                  WHERE NOT EXISTS (SELECT 1 FROM "Profiles" WHERE path = 'hamburgir');
                  INSERT INTO "Profiles" (path, name, avatar, themeId, themeFg, themeBg)
                  SELECT 'jobsearch', 'jobsearch', 'shopping', 'default-theme@mozilla.org', 'rgb(255,255,255)', 'rgb(28,27,34)'
                  WHERE NOT EXISTS (SELECT 1 FROM "Profiles" WHERE path = 'jobsearch');
                  UPDATE "Profiles" SET name = 'hamburgir' WHERE path = 'hamburgir' AND name = 'Original profile';
                  SQL
                '';
              };
            })
          ]
          ++ map (outputs.lib.mkHome pkgs) [
            {name = "google-chrome";}
          ];
      }
    )
  ];
}
