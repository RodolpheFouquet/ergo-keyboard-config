{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    zmk-nix = {
      url = "github:lilyinstarlight/zmk-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, zmk-nix }: let
    forAllSystems = nixpkgs.lib.genAttrs (nixpkgs.lib.attrNames zmk-nix.packages);
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      default = totem;

      totem = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "totem";

        src = nixpkgs.lib.sourceFilesBySuffices self [ ".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig" ];

        board = "seeeduino_xiao_ble";
        shield = "totem_%PART%";

        zephyrDepsHash = "sha256-8XOD1vIu0wdLO2rMoYWjvkeQpDL5H5Dz/asSf0m0AIw=";

        meta = {
          description = "ZMK firmware for TOTEM";
          license = nixpkgs.lib.licenses.mit;
          platforms = nixpkgs.lib.platforms.all;
        };
      };

      eyelash_corne = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "eyelash_corne";

        src = nixpkgs.lib.sourceFilesBySuffices self [ ".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig" ];

        board = "eyelash_corne_%PART%";

        zephyrDepsHash = "sha256-8XOD1vIu0wdLO2rMoYWjvkeQpDL5H5Dz/asSf0m0AIw=";

        meta = {
          description = "ZMK firmware for Eyelash Corne";
          license = nixpkgs.lib.licenses.mit;
          platforms = nixpkgs.lib.platforms.all;
        };
      };

      sofle = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "sofle";

        src = nixpkgs.lib.sourceFilesBySuffices self [ ".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig" ];

        board = "nice_nano_v2";
        shield = "sofle_%PART%";

        zephyrDepsHash = "sha256-8XOD1vIu0wdLO2rMoYWjvkeQpDL5H5Dz/asSf0m0AIw=";

        meta = {
          description = "ZMK firmware for Sofle";
          license = nixpkgs.lib.licenses.mit;
          platforms = nixpkgs.lib.platforms.all;
        };
      };

      flash-totem = zmk-nix.packages.${system}.flash.override { firmware = totem; };
      flash-eyelash_corne = zmk-nix.packages.${system}.flash.override { firmware = eyelash_corne; };
      flash-sofle = zmk-nix.packages.${system}.flash.override { firmware = sofle; };
      update = zmk-nix.packages.${system}.update;

      # Keymap drawings
      keymap-totem = pkgs.stdenv.mkDerivation {
        name = "keymap-totem";
        src = self;
        buildInputs = [ pkgs.keymap-drawer ];
        buildPhase = ''
          mkdir -p $out
          keymap parse -z config/totem.keymap > keymap.yaml
          keymap -c keymap-drawer/totem.yaml draw keymap.yaml > $out/totem.svg
        '';
        installPhase = "true";
      };

      keymap-eyelash_corne = pkgs.stdenv.mkDerivation {
        name = "keymap-eyelash_corne";
        src = self;
        buildInputs = [ pkgs.keymap-drawer ];
        buildPhase = ''
          mkdir -p $out
          keymap parse -z config/eyelash_corne.keymap > keymap.yaml
          keymap draw keymap.yaml > $out/eyelash_corne.svg
        '';
        installPhase = "true";
      };

      keymap-sofle = pkgs.stdenv.mkDerivation {
        name = "keymap-sofle";
        src = self;
        buildInputs = [ pkgs.keymap-drawer ];
        buildPhase = ''
          mkdir -p $out
          keymap parse -z config/sofle.keymap > keymap.yaml
          keymap draw keymap.yaml > $out/sofle.svg
        '';
        installPhase = "true";
      };

    });

    devShells = forAllSystems (system: {
      default = zmk-nix.devShells.${system}.default;
    });
  };
}
