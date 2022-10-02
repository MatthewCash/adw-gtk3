{
    description = "An unofficial GTK3 port of libadwaita";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-22.05";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = inputs @ { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in rec {
            # Derivation sourced from https://github.com/NixOS/nixpkgs/issues/162432#issuecomment-1056928781
            defaultPackage = pkgs.stdenvNoCC.mkDerivation {
                name = "adw-gtk3";
                src = ./.;
                nativeBuildInputs = with pkgs; [
                      meson
                      ninja
                      sassc
                ];
                postPatch = ''
                    chmod +x gtk/src/adw-gtk3-dark/gtk-3.0/install-dark-theme.sh
                    patchShebangs gtk/src/adw-gtk3-dark/gtk-3.0/install-dark-theme.sh
                '';
            };
        }
    );
}
