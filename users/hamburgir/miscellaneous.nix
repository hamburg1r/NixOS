{...}: {
  config.dendritic.home.hamburgir = [
    (
      {config, lib, ...}: {
        gtk = {
          gtk3.bookmarks = let
            home = dir: "file://${config.home.homeDirectory}/${dir}";
          in [
            # "file://${config.home.homeDirectory}/"
            (home "Documents")
            (home "Downloads")
            (home "Music")
            (home "Pictures")
            (home "Templates")
            (home "Videos")
            "file:///tmp"
          ];
        };
        xdg.configFile = {
          "gtk-3.0/bookmarks".force = true;
          "keepassxc/keepassxc.ini".force = true;
          # The niri module uses this name for the niri/config.kdl target.
          "niri-config".force = true;
        } // lib.optionalAttrs config.xdg.mimeApps.enable {
          "mimeapps.list".force = true;
        };
        home.file.".mozilla/native-messaging-hosts".force = true;

        services.network-manager-applet.enable = !config.programs.dank-material-shell.enable;
      }
    )
  ];
}
