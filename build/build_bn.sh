#!/bin/bash -eu

BUILD_DIR="build_stable"

rm -rf "${BUILD_DIR}"

cmake -B "$BUILD_DIR" \
    -G Ninja -S . \
    -DBN_INSTALL_DIR=/opt/binaryninja \
    -DBN_API_BUILD_EXAMPLES=ON

#   -DHEADLESS=ON

cmake --build "$BUILD_DIR" -j64
