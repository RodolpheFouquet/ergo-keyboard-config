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
    packages = forAllSystems (system: rec {
      default = totem;

      totem = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "totem";

        src = nixpkgs.lib.sourceFilesBySuffices self [ ".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig" ];

        board = "seeeduino_xiao_ble";
        shield = "totem_%PART%";

        zephyrDepsHash = "sha256-wTe5Sw5ajPVuAADXcjnAcm3ZH5bnjuIJkMQPZUwF5ic=";

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

        zephyrDepsHash = "sha256-wTe5Sw5ajPVuAADXcjnAcm3ZH5bnjuIJkMQPZUwF5ic=";

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

        zephyrDepsHash = "sha256-wTe5Sw5ajPVuAADXcjnAcm3ZH5bnjuIJkMQPZUwF5ic=";

        meta = {
          description = "ZMK firmware for Sofle";
          license = nixpkgs.lib.licenses.mit;
          platforms = nixpkgs.lib.platforms.all;
        };
      };

      charybdis = zmk-nix.legacyPackages.${system}.buildSplitKeyboard {
        name = "charybdis";

        src = nixpkgs.lib.sourceFilesBySuffices self [ ".board" ".cmake" ".conf" ".defconfig" ".dts" ".dtsi" ".json" ".keymap" ".overlay" ".shield" ".yml" "_defconfig" ];

        board = "nice_nano_v2";
        shield = "charybdis_%PART%";

        zephyrDepsHash = "sha256-s2aS0oZxzqESwWoBEK4OC2ebgZjTqW5NS2P6zQ4vf7o=";

        meta = {
          description = "ZMK firmware for Charybdis";
          license = nixpkgs.lib.licenses.mit;
          platforms = nixpkgs.lib.platforms.all;
        };
      };

      flash-totem = zmk-nix.packages.${system}.flash.override { firmware = totem; };
      flash-eyelash_corne = zmk-nix.packages.${system}.flash.override { firmware = eyelash_corne; };
      flash-sofle = zmk-nix.packages.${system}.flash.override { firmware = sofle; };
      flash-charybdis = zmk-nix.packages.${system}.flash.override { firmware = charybdis; };
      update = zmk-nix.packages.${system}.update;
    });

    devShells = forAllSystems (system: {
      default = zmk-nix.devShells.${system}.default;
    });
  };
}
