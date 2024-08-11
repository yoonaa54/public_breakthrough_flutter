{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-unstable") {} }:
# nix-shell --fallback
# possibly solves invocation failures depending on your os/arch
let
  showDartVersion = "dart --version";
  showDartPath = "which dart";
in
pkgs.mkShellNoCC {
  buildInputs = with pkgs;[
    bundler
    flutterPackages.v3_22
    git
    gnumake
    pkgs.git-credential-oauth
    ruby_3_1
    vscode
    vscode-extensions.arrterian.nix-env-selector
    vscode-extensions.dart-code.flutter
    # flutterPackages.v3_24 - _23 is currently latest available
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    cocoapods
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
    code --install-extension codeium.codeium
    code --install-extension dart-code.flutter@3.92.0
  '';
}





