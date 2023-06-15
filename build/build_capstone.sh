#!/bin/bash -eu

rm -f libcapstone.so*  libcapstone.a bindings/python/libcapstone.so
# make clean
export CAPSTONE_ARCHS="arm aarch64 mips powerpc x86 riscv wasm bpf sh"
export CAPSTONE_X86_ATT_DISABLE=yes

./make.sh

ln libcapstone.so.5 libcapstone.so
ln libcapstone.so.5 bindings/python/libcapstone.so 

cd bindings/python
make clean

python3 setup.py bdist_wheel
python2 setup.py bdist_wheel
