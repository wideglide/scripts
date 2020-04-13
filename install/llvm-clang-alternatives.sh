#!/usr/bin/env bash

# Remove all existing alternatives
sudo update-alternatives --remove-all llvm
sudo update-alternatives --remove-all llvm-config
sudo update-alternatives --remove-all clang
sudo update-alternatives --remove-all clang++

# exit on first error
set -e

# Ubuntu distro
DIST=`lsb_release -cs`

# To Install llvm/clang
wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys BA9EF27F
# echo sudo apt-add-repository -y "deb http://apt.llvm.org/${DIST}/ llvm-toolchain-${DIST}-6.0 main"
echo "deb https://apt.llvm.org/${DIST}/ llvm-toolchain-${DIST} main" | sudo tee /etc/apt/sources.list.d/llvm.list
echo "deb https://apt.llvm.org/${DIST}/ llvm-toolchain-${DIST}-10 main" | sudo tee /etc/apt/sources.list.d/llvm-10.list
echo "deb https://apt.llvm.org/${DIST}/ llvm-toolchain-${DIST}-9 main" | sudo tee /etc/apt/sources.list.d/llvm-9.list
echo "deb https://apt.llvm.org/${DIST}/ llvm-toolchain-${DIST}-8 main" | sudo tee /etc/apt/sources.list.d/llvm-8.list
echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu ${DIST} main" | sudo tee /etc/apt/sources.list.d/ubuntu-toolchain-r-ubuntu-test-${DIST}.list
sudo apt-get -qq update

install_llvm_10() {
    sudo apt-get -qq install -y clang-10 llvm-10 lld-10 lldb-10
    sudo apt-get -qq install -y clang-{format,tidy,tools}-10 clang-10-doc clang-10-examples
    sudo apt-get -qq install -y libc++-10-dev libc++abi-10-dev llvm-10-dev
    # llvm-10 and clang-10
    sudo update-alternatives \
      --install /usr/lib/llvm              llvm             /usr/lib/llvm-10  100 \
        --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-10  \
        --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-10 \
        --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-10 \
        --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-10 \
        --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-10 \
        --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-10 \
        --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-10 \
        --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-10 \
        --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-10 \
        --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-10 \
        --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-10 \
        --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-10 \
        --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-10 \
        --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-10 \
        --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-10 \
        --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-10 \
        --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-10 \
        --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-10 \
        --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-10 \
        --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-10

    sudo update-alternatives \
      --install /usr/bin/clang                 clang                  /usr/bin/clang-10  100 \
      --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-10 \
      --slave   /usr/bin/lld                   lld                    /usr/bin/lld-10 \
      --slave   /usr/bin/clang-format          clang-format           /usr/bin/clang-format-10  \
      --slave   /usr/bin/clang-tidy            clang-tidy             /usr/bin/clang-tidy-10  \
      --slave   /usr/bin/clang-tidy-diff.py    clang-tidy-diff.py     /usr/bin/clang-tidy-diff-10.py \
      --slave   /usr/bin/clang-include-fixer   clang-include-fixer    /usr/bin/clang-include-fixer-10 \
      --slave   /usr/bin/clang-offload-bundler clang-offload-bundler  /usr/bin/clang-offload-bundler-10 \
      --slave   /usr/bin/clang-check           clang-check            /usr/bin/clang-check-10 \
      --slave   /usr/bin/scan-view             scan-view              /usr/bin/scan-view-10 \
      --slave   /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-10 \
      --slave   /usr/bin/clang-query           clang-query            /usr/bin/clang-query-10 \
      --slave   /usr/bin/modularize            modularize             /usr/bin/modularize-10 \
      --slave   /usr/bin/sancov                sancov                 /usr/bin/sancov-10 \
      --slave   /usr/bin/c-index-test          c-index-test           /usr/bin/c-index-test-10 \
      --slave   /usr/bin/clang-reorder-fields  clang-reorder-fields   /usr/bin/clang-reorder-fields-10 \
      --slave   /usr/bin/clang-change-namespace clang-change-namespace  /usr/bin/clang-change-namespace-10 \
      --slave   /usr/bin/clang-import-test     clang-import-test      /usr/bin/clang-import-test-10 \
      --slave   /usr/bin/scan-build            scan-build             /usr/bin/scan-build-10 \
      --slave   /usr/bin/scan-build-py         scan-build-py          /usr/bin/scan-build-py-10 \
      --slave   /usr/bin/clang-cl              clang-cl               /usr/bin/clang-cl-10 \
      --slave   /usr/bin/clang-rename          clang-rename           /usr/bin/clang-rename-10 \
      --slave   /usr/bin/find-all-symbols      find-all-symbols       /usr/bin/find-all-symbols-10 \
      --slave   /usr/bin/lldb                  lldb                   /usr/bin/lldb-10 \
      --slave   /usr/bin/lldb-server           lldb-server            /usr/bin/lldb-server-10
}

# llvm-9 and clang-9
install_llvm_9() {
    sudo apt-get -qq install -y clang-9 llvm-9 lld-9 lldb-9 python-yaml
    sudo apt-get -qq install -y clang-{format,tidy,tools}-9 clang-9-doc clang-9-examples
    sudo update-alternatives \
      --install /usr/lib/llvm              llvm             /usr/lib/llvm-9  90 \
        --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-9  \
        --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-9 \
        --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-9 \
        --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-9 \
        --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-9 \
        --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-9 \
        --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-9 \
        --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-9 \
        --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-9 \
        --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-9 \
        --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-9 \
        --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-9 \
        --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-9 \
        --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-9 \
        --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-9 \
        --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-9 \
        --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-9 \
        --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-9 \
        --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-9 \
        --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-9

    sudo update-alternatives \
      --install /usr/bin/clang                 clang                  /usr/bin/clang-9  90 \
      --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-9 \
      --slave   /usr/bin/lld                   lld                    /usr/bin/lld-9 \
      --slave   /usr/bin/clang-format          clang-format           /usr/bin/clang-format-9  \
      --slave   /usr/bin/clang-tidy            clang-tidy             /usr/bin/clang-tidy-9  \
      --slave   /usr/bin/clang-tidy-diff.py    clang-tidy-diff.py     /usr/bin/clang-tidy-diff-9.py \
      --slave   /usr/bin/clang-include-fixer   clang-include-fixer    /usr/bin/clang-include-fixer-9 \
      --slave   /usr/bin/clang-offload-bundler clang-offload-bundler  /usr/bin/clang-offload-bundler-9 \
      --slave   /usr/bin/clang-check           clang-check            /usr/bin/clang-check-9 \
      --slave   /usr/bin/scan-view             scan-view              /usr/bin/scan-view-9 \
      --slave   /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-9 \
      --slave   /usr/bin/clang-query           clang-query            /usr/bin/clang-query-9 \
      --slave   /usr/bin/modularize            modularize             /usr/bin/modularize-9 \
      --slave   /usr/bin/sancov                sancov                 /usr/bin/sancov-9 \
      --slave   /usr/bin/c-index-test          c-index-test           /usr/bin/c-index-test-9 \
      --slave   /usr/bin/clang-reorder-fields  clang-reorder-fields   /usr/bin/clang-reorder-fields-9 \
      --slave   /usr/bin/clang-change-namespace clang-change-namespace  /usr/bin/clang-change-namespace-9 \
      --slave   /usr/bin/clang-import-test     clang-import-test      /usr/bin/clang-import-test-9 \
      --slave   /usr/bin/scan-build            scan-build             /usr/bin/scan-build-9 \
      --slave   /usr/bin/scan-build-py         scan-build-py          /usr/bin/scan-build-py-9 \
      --slave   /usr/bin/clang-cl              clang-cl               /usr/bin/clang-cl-9 \
      --slave   /usr/bin/clang-rename          clang-rename           /usr/bin/clang-rename-9 \
      --slave   /usr/bin/find-all-symbols      find-all-symbols       /usr/bin/find-all-symbols-9 \
      --slave   /usr/bin/lldb                  lldb                   /usr/bin/lldb-9 \
      --slave   /usr/bin/lldb-server           lldb-server            /usr/bin/lldb-server-9
}

# llvm-8 and clang-8
install_llvm_8() {
    sudo apt-get -qq install -y clang-8 llvm-8 lld-8
    sudo apt-get -qq install -y clang-{format,tidy,tools}-8 clang-8-doc clang-8-examples
    sudo update-alternatives \
      --install /usr/lib/llvm              llvm             /usr/lib/llvm-8  80 \
        --slave   /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-8  \
        --slave   /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-8 \
        --slave   /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-8 \
        --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-8 \
        --slave   /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-8 \
        --slave   /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-8 \
        --slave   /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-8 \
        --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-8 \
        --slave   /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-8 \
        --slave   /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-8 \
        --slave   /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-8 \
        --slave   /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-8 \
        --slave   /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-8 \
        --slave   /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-8 \
        --slave   /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-8 \
        --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-8 \
        --slave   /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-8 \
        --slave   /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-8 \
        --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-8 \
        --slave   /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-8

    sudo update-alternatives \
      --install /usr/bin/clang                 clang                  /usr/bin/clang-8  80 \
      --slave   /usr/bin/clang++               clang++                /usr/bin/clang++-8 \
      --slave   /usr/bin/lld                   lld                    /usr/bin/lld-8 \
      --slave   /usr/bin/clang-format          clang-format           /usr/bin/clang-format-8  \
      --slave   /usr/bin/clang-tidy            clang-tidy             /usr/bin/clang-tidy-8  \
      --slave   /usr/bin/clang-tidy-diff.py    clang-tidy-diff.py     /usr/bin/clang-tidy-diff-8.py \
      --slave   /usr/bin/clang-include-fixer   clang-include-fixer    /usr/bin/clang-include-fixer-8 \
      --slave   /usr/bin/clang-offload-bundler clang-offload-bundler  /usr/bin/clang-offload-bundler-8 \
      --slave   /usr/bin/clang-check           clang-check            /usr/bin/clang-check-8 \
      --slave   /usr/bin/scan-view             scan-view              /usr/bin/scan-view-8 \
      --slave   /usr/bin/clang-apply-replacements clang-apply-replacements /usr/bin/clang-apply-replacements-8 \
      --slave   /usr/bin/clang-query           clang-query            /usr/bin/clang-query-8 \
      --slave   /usr/bin/modularize            modularize             /usr/bin/modularize-8 \
      --slave   /usr/bin/sancov                sancov                 /usr/bin/sancov-8 \
      --slave   /usr/bin/c-index-test          c-index-test           /usr/bin/c-index-test-8 \
      --slave   /usr/bin/clang-reorder-fields  clang-reorder-fields   /usr/bin/clang-reorder-fields-8 \
      --slave   /usr/bin/clang-change-namespace clang-change-namespace  /usr/bin/clang-change-namespace-8 \
      --slave   /usr/bin/clang-import-test     clang-import-test      /usr/bin/clang-import-test-8 \
      --slave   /usr/bin/scan-build            scan-build             /usr/bin/scan-build-8 \
      --slave   /usr/bin/scan-build-py         scan-build-py          /usr/bin/scan-build-py-8 \
      --slave   /usr/bin/clang-cl              clang-cl               /usr/bin/clang-cl-8 \
      --slave   /usr/bin/clang-rename          clang-rename           /usr/bin/clang-rename-8 \
      --slave   /usr/bin/find-all-symbols      find-all-symbols       /usr/bin/find-all-symbols-8 \
      --slave   /usr/bin/lldb                  lldb                   /usr/bin/lldb-8 \
      --slave   /usr/bin/lldb-server           lldb-server            /usr/bin/lldb-server-8
}

# llvm-6.0 and clang-6.0
install_llvm_6() {
    sudo apt-get -qq install -y clang-6.0 llvm-6.0 lld-6.0
    sudo apt-get -qq install -y clang-format-6.0 clang-tidy-6.0

    sudo update-alternatives \
      --install /usr/lib/llvm            llvm             /usr/lib/llvm-6.0  10 \
        --slave /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-6.0  \
        --slave /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-6.0 \
        --slave /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-6.0 \
        --slave /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-6.0 \
        --slave /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-6.0 \
        --slave /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-6.0 \
        --slave /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-6.0 \
        --slave /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-6.0 \
        --slave /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-6.0 \
        --slave /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-6.0 \
        --slave /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-6.0 \
        --slave /usr/bin/llvm-mcmarkup     llvm-mcmarkup    /usr/bin/llvm-mcmarkup-6.0 \
        --slave /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-6.0 \
        --slave /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-6.0 \
        --slave /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-6.0 \
        --slave /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-6.0 \
        --slave /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-6.0 \
        --slave /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-6.0 \
        --slave /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-6.0 \
        --slave /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-6.0 \
        --slave /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-6.0

    sudo update-alternatives \
      --install /usr/bin/clang                clang        /usr/bin/clang-6.0     10 \
        --slave   /usr/bin/clang++              clang++      /usr/bin/clang++-6.0 \
        --slave   /usr/bin/lld                  lld          /usr/bin/lld-6.0 \
        --slave   /usr/bin/clang-format         clang-format /usr/bin/clang-format-6.0  \
        --slave   /usr/bin/clang-tidy           clang-tidy   /usr/bin/clang-tidy-6.0  \
        --slave   /usr/bin/clang-tidy-diff.py   clang-tidy-diff.py /usr/bin/clang-tidy-diff-6.0.py
}

# llvm-4.0 and clang-4.0
install_llvm_4() {
    sudo apt-get -qq install -y clang-4.0 llvm-4.0 lld-4.0
    sudo update-alternatives \
      --install /usr/lib/llvm            llvm             /usr/lib/llvm-4.0  10 \
        --slave /usr/bin/llvm-config       llvm-config      /usr/bin/llvm-config-4.0  \
        --slave /usr/bin/llvm-ar           llvm-ar          /usr/bin/llvm-ar-4.0 \
        --slave /usr/bin/llvm-as           llvm-as          /usr/bin/llvm-as-4.0 \
        --slave /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  /usr/bin/llvm-bcanalyzer-4.0 \
        --slave /usr/bin/llvm-cov          llvm-cov         /usr/bin/llvm-cov-4.0 \
        --slave /usr/bin/llvm-diff         llvm-diff        /usr/bin/llvm-diff-4.0 \
        --slave /usr/bin/llvm-dis          llvm-dis         /usr/bin/llvm-dis-4.0 \
        --slave /usr/bin/llvm-dwarfdump    llvm-dwarfdump   /usr/bin/llvm-dwarfdump-4.0 \
        --slave /usr/bin/llvm-extract      llvm-extract     /usr/bin/llvm-extract-4.0 \
        --slave /usr/bin/llvm-link         llvm-link        /usr/bin/llvm-link-4.0 \
        --slave /usr/bin/llvm-mc           llvm-mc          /usr/bin/llvm-mc-4.0 \
        --slave /usr/bin/llvm-mcmarkup     llvm-mcmarkup    /usr/bin/llvm-mcmarkup-4.0 \
        --slave /usr/bin/llvm-nm           llvm-nm          /usr/bin/llvm-nm-4.0 \
        --slave /usr/bin/llvm-objdump      llvm-objdump     /usr/bin/llvm-objdump-4.0 \
        --slave /usr/bin/llvm-ranlib       llvm-ranlib      /usr/bin/llvm-ranlib-4.0 \
        --slave /usr/bin/llvm-readobj      llvm-readobj     /usr/bin/llvm-readobj-4.0 \
        --slave /usr/bin/llvm-rtdyld       llvm-rtdyld      /usr/bin/llvm-rtdyld-4.0 \
        --slave /usr/bin/llvm-size         llvm-size        /usr/bin/llvm-size-4.0 \
        --slave /usr/bin/llvm-stress       llvm-stress      /usr/bin/llvm-stress-4.0 \
        --slave /usr/bin/llvm-symbolizer   llvm-symbolizer  /usr/bin/llvm-symbolizer-4.0 \
        --slave /usr/bin/llvm-tblgen       llvm-tblgen      /usr/bin/llvm-tblgen-4.0

    sudo update-alternatives \
      --install /usr/bin/clang                clang        /usr/bin/clang-4.0     10 \
      --slave   /usr/bin/clang++              clang++      /usr/bin/clang++-4.0 \
      --slave   /usr/bin/lld                  lld          /usr/bin/lld-4.0 \
      --slave   /usr/bin/clang-format         clang-format /usr/bin/clang-format-4.0  \
      --slave   /usr/bin/clang-tidy           clang-tidy   /usr/bin/clang-tidy-4.0  \
      --slave   /usr/bin/clang-tidy-diff.py   clang-tidy-diff.py /usr/bin/clang-tidy-diff-4.0.py
}
