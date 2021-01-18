#!/bin/bash

INSTALL_DEBS="BAT FD RG"

BAT_VERSION=0.13.0
FD_VERSION=7.5.0
RG_VERSION=12.0.1
FZF_VERSION=0.21.1
HEXYL_VERSION=0.7.0
DIVE_VERSION=0.9.2

declare -a URLS

URLS[BAT]="https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb"
URLS[FD]="https://github.com/sharkdp/fd/releases/download/v${FD_VERSION}/fd_${FD_VERSION}_amd64.deb"
URLS[HEXYL]="https://github.com/sharkdp/hexyl/releases/download/v${HEXYL_VERSION}/hexyl_${HEXYL_VERSION}_amd64.deb"
URLS[RG]="https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep_${RG_VERSION}_amd64.deb"
URLS[FZF]="https://github.com/junegunn/fzf-bin/releases/download/${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tgz"
URLS[DIVE]="https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb"

install_deb() {
    wget -qO /tmp/${1}.deb $URLS[$1]
    sudo dpkg -i /tmp/${1}.deb
    rm -f /tmp/${1}.deb
}

install_tgz() {
   wget -qO /tmp/${1}.tgz $URLS[FZF]
   tar -C /tmp -xf /tmp/${1}.tgz
   sudo cp /tmp/fzf /usr/local/bin/
   sudo chmod +x /usr/local/bin/fzf
}

install_fzf(){
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}


for pkg in $INSTALL_DEBS; do
    install_deb $pkg
done
