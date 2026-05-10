#!/usr/bin/env bash
#=============================================================================
#  MusE
#  Linux Music Editor
#  $Id:$
#
#  Copyright (C) 1999-2011 by Werner Schweer and others
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the
#  Free Software Foundation, Inc.,
#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
#=============================================================================

if [ -d build ]; then
        echo "Build dir already exists"
else
	echo "Create build dir"
	mkdir build
fi
cd build

# to put the resulting binary in a specific location add -DCMAKE_INSTALL_PREFIX=<some location>
cmake -DCMAKE_BUILD_TYPE=release -DMODULES_BUILD_STATIC=ON \
  -DCMAKE_CXX_FLAGS="-I$(pkg-config --variable=libdir sigc++-2.0)/sigc++-2.0/include" \
  -DGTK2_GTKMMCONFIG_INCLUDE_DIR=$(pkg-config --variable=libdir gtkmm-2.4)/gtkmm-2.4/include \
  -DGTK2_GDKMMCONFIG_INCLUDE_DIR=$(pkg-config --variable=libdir gdkmm-2.4)/gdkmm-2.4/include \
  -DGTK2_GLIBMMCONFIG_INCLUDE_DIR=$(pkg-config --variable=libdir glibmm-2.4)/glibmm-2.4/include \
-DCMAKE_CXX_FLAGS="-I$(pkg-config --variable=libdir sigc++-2.0)/sigc++-2.0/include \
  -I$(pkg-config --variable=libdir pangomm-1.4)/pangomm-1.4/include \
  -I$(pkg-config --variable=libdir cairomm-1.0)/cairomm-1.0/include \
  -I$(pkg-config --variable=libdir atkmm-1.6)/atkmm-1.6/include \
  -I$(pkg-config --variable=libdir giomm-2.4)/giomm-2.4/include" \
  .. && make all && echo "Build was OK, now enter the 'build' dir and run 'make install' as root"

