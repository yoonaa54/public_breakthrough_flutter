{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable") {} }:
# nix-shell --fallback
# possibly solves invocation failures depending on your os/arch
let
  showDartVersion = "dart --version";
  showDartPath = "which dart";
in
pkgs.mkShellNoCC {
  buildInputs = with pkgs;[
    pkgs.git-credential-oauth
    git
    flutterPackages.v3_22
    # flutterPackages.v3_24 - _23 is currently latest available
  ];
  shellHook = ''
    # make sure `pub global` commands are reachable:
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    # echo ""
    # echo "Activating serverpod globally..."
    # dart pub global activate serverpod_cli 2.0.2
    # echo ""
    # echo "Activating jaspr globally..."
    # dart pub global activate jaspr_cli 0.13.3
    echo ""
    ${showDartVersion}
    ${showDartPath}
    echo ""
    flutter doctor --verbose
    echo ""
    echo ""
  '';
}





