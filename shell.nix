{
  pkgs ? import <nixpkgs> { config.allowUnfree = true; },
}:

pkgs.mkShell {
  nativeBuildInputs = [ pkgs.qt5.wrapQtAppsHook ];

  shellHook = ''
    export GTK2_GTKMMCONFIG_INCLUDE_DIR="${pkgs.gtkmm2}/lib/gtkmm-2.4/include"
    export GTK2_GDKMMCONFIG_INCLUDE_DIR="${pkgs.gtkmm2}/lib/gdkmm-2.4/include"
    export GTK2_GLIBMMCONFIG_INCLUDE_DIR="${pkgs.glibmm}/lib/glibmm-2.4/include"
  '';

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

    cairomm
    pangomm
    libsigcxx
    atkmm
    glibmm
  ];
}
