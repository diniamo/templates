{
  description = "";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    systems.url = "github:nix-systems/default";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    systems,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import systems;

      perSystem = {pkgs, ...}: let
        default = pkgs.callPackage ./. {inherit systems;};
      in {
        formatter = pkgs.alejandra;

        devShells.default = pkgs.mkShell {
          inputsFrom = [default];
          packages = with pkgs; [
            # Nix
            statix
            deadnix

            # Rust
            clippy
            rustfmt
          ];
        };

        packages = {
          inherit default;
        };
      };
    };
}
