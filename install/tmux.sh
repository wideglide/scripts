#!/bin/bash

git clone https://github.com/tmux/tmux


sudo apt update
sudo apt install -y automake bison build-essential libevent-dev libncurses-dev pkg-config

cd tmux
./autogen.sh
./configure
make -j $(nproc)
sudo make isntall
