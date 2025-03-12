{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = with pkgs; [
    android-tools
    git-repo
    sourcekit-lsp
  ];
}
