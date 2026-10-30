# Niri helpers.
#
# Upstream niri only sends frame callbacks to invisible windows at ~1 FPS.
# Games like Elden Ring Nightreign see that as a massive framerate drop and
# drop their online session when backgrounded. The `force-render` window rule
# (niri PR #4392) keeps selected windows rendering at a chosen FPS while they
# are hidden; patch it into the package until it lands upstream.
{lib}: {
  forceRenderPackage = inputs: pkgs:
    inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable.overrideAttrs (old: {
      patches = (old.patches or []) ++ [../modules/home-manager/desktop/niri/patches/niri-force-render.patch];
    });
}
