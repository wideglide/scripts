#!/bin/bash


upgrade_pip() {
  python3 -m pip install --upgrade --user pip
  python3 -m pip install --upgrade --user setuptools
  python3 -m pip install --upgrade --user wheel build
}

install_unblob() {
  sudo apt install android-sdk-libsparse-utils e2fsprogs p7zip-full unar zlib1g-dev liblzo2-dev lzop lziprecover libhyperscan-dev zstd lz4
  python3 -m pip install --upgrade --user unblob

  unblob --show-external-dependencies
}

install_sasquatch() {
  curl -L -o /tmp/sasquatch_1.0_amd64.deb https://github.com/onekey-sec/sasquatch/releases/download/sasquatch-v4.5.1-4/sasquatch_1.0_amd64.deb
  sudo apt install /tmp/sasquatch_1.0_amd64.deb
  rm /tmp/sasquatch_1.0_amd64.deb
}

install_cve_bin_tool() {
  sudo apt install file tar unzip rpm2cpio cpio cabextract 7zip squashfuse squashfs-tools
  python3 -m pip install --upgrade --user cve-bin-tool
}
