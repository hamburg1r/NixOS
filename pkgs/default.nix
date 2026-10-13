# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{
  inputs,
  pkgs,
  ...
}: rec {
  # example = pkgs.callPackage ./example { };
  omniroute = pkgs.callPackage ./omniroute {};
}
