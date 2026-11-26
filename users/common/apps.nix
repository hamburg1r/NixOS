{...}: {
  config.dendritic.home.common = [
    (
      {...}: {
        desktop.apps = {
          cliphist.enable = true;
          firefox.enable = true;
          google-chrome.enable = true;
          nemo.enable = true;
          nh.enable = true;
          pear-desktop.enable = true;
          ristretto.enable = true;
          wl-clipboard.enable = true;
        };

        programs.keepassxc = {
          enable = true;
          settings.Browser = {
            Enabled = true;
            UpdateBinaryPath = false;
          };
        };
      }
    )
  ];
}
