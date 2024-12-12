{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    packages = with pkgs; [
      rustc
      cargo
      clippy
      rustfmt
    ];
  }
