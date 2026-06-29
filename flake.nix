{
  description = "MusE Sequencer Dev Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    devShells.x86_64-linux.default =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          qt5.wrapQtAppsHook
          pkg-config
          cmake
          gnumake
          clang-tools
        ];

        buildInputs = with pkgs; [
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
          gtkmm2
          gtk2
          dssi
          liblo
          python3Packages.pyqt5
          rtaudio

          cairomm
          pangomm
          libsigcxx
          atkmm
          glibmm
        ];
      };
  };
}
