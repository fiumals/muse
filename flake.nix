{
  description = "muse development flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = [ pkgs.qt5.wrapQtAppsHook ];

        buildInputs = with pkgs; [
          pkg-config
          clang-tools
          cmake
          gnumake
          qt5.qtbase
          qt5.qttools
          qt5.qtsvg
          qt5.qtxmlpatterns
          gcc
          libsndfile
          libsamplerate
          jack2
          ladspa-header
          rubberband
          kdePackages.extra-cmake-modules

          alsa-lib
          fluidsynth
          libinstpatch
          lrdf
          lilv
          sord
          serd
          lv2
          vst2-sdk
          gtkmm2
          gtk2
          dssi
          liblo
          python3Packages.pyqt5
          rtaudio

          cairo
          pango

          cairomm
          pangomm
          libsigcxx
          atkmm
          glibmm
        ];

        shellHook = ''
          				export GTK2_GTKMMCONFIG_INCLUDE_DIR="${pkgs.gtkmm2}/lib/gtkmm-2.4/include"
          				export GTK2_GDKMMCONFIG_INCLUDE_DIR="${pkgs.gtkmm2}/lib/gdkmm-2.4/include"
          				export GTK2_GLIBMMCONFIG_INCLUDE_DIR="${pkgs.glibmm}/lib/glibmm-2.4/include"

          				  alias compile="cd src && ./compile_muse.sh"

          				  echo "yo"
          				  echo "'compile' to build the project"
        '';
      };

      # This lets you run 'nix run .#compile' straight from your host terminal
      apps.${system}.compile = {
        type = "app";
        program = toString (
          pkgs.writeShellScript "compile-muse" ''
            cd src
            ./compile_muse.sh
          ''
        );
      };
    };
}
