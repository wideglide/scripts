#!/bin/bash -eu

sudo apt install --no-install-recommends \
 xfce4 \
 xrdp xorg x11-apps x11-utils xorgxrdp \
 xfce4-terminal lxterminal suckless-tools xterm \
 mousepad  \
 lm-sensors \
 openbox \
 i3 \
 elementary-xfce-icon-theme \
 fonts-ubuntu \
 greybird-gtk-theme

sudo apt install --no-install-recommends \
 fonts-linuxlibertine \
 fonts-roboto \
 fonts-freefont-ttf \
 duf \
 aria2 \
 dictionaries-common 

sudo apt install --no-install-recommends \
 python3-dev python3-pip python3-venv libpython3-dev \
 python3.11-dev libpython3.11-dev python3.11-venv \
 libsecret-1-0 \
 cmake \
 7zip libarchive-dev zstd duf ninja-build \
 llvm-dev build-essential automake autoconf bison flex clang-tools libtool pkg-config \
 libpcre3-dev bison automake autotools-dev patchelf \
 unzip zip \
 libboost-dev
