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

  outputs = inputs: let
    systems = import inputs.systems;
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      inherit systems;

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
