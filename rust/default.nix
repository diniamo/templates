{
  rustPlatform,
  lib,
  systems,
}: let
  cargoPackage = (builtins.fromTOML (builtins.readFile ./Cargo.toml)).package;
in
  rustPlatform.buildRustPackage rec {
    pname = cargoPackage.name;
    version = cargoPackage.version;

    src = builtins.path {
      name = "${pname}-source";
      path = ./.;
    };

    cargoLock.lockFile = ./Cargo.lock;

    meta = with lib; {
      description = cargoPackage.description;
      homepage = "https://github.com/diniamo/";
      license = null;
      maintainers = with maintainers; [diniamo];
      platforms = systems;
    };
  }
