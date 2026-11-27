{
  lib,
  stdenvNoCC,
  makeWrapper,
  nodejs_26,
  src,
}:
stdenvNoCC.mkDerivation {
  pname = "rea-agents";
  version = "6.10.1";
  inherit src;

  nativeBuildInputs = [makeWrapper];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/lib/rea" "$out/bin"
    cp -R . "$out/lib/rea/"
    makeWrapper ${nodejs_26}/bin/node "$out/bin/rea" \
      --add-flags "$out/lib/rea/scripts/rea.mjs"
    runHook postInstall
  '';

  meta = {
    description = "Reverse engineering CLI and MCP server";
    homepage = "https://github.com/morluto/rea";
    license = lib.licenses.mit;
    mainProgram = "rea";
    platforms = lib.platforms.linux;
  };
}
