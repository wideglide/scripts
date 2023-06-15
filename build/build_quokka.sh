#!/bin/bash -eu

BUILD_DIR=build83
BUILD_TYPE=Release
IDASDK_ROOT="/opt/ida/idasdk_pro83"
IDA_BIN="/opt/ida/ida-8.3"

rm -rf "${BUILD_DIR}"
rm -rf "dist"

cmake -B "$BUILD_DIR" \
    -G Ninja -S . \
    -DIdaSdk_ROOT_DIR:STRING="$IDASDK_ROOT" \
    -DIda_BIN_DIR:STRING="$IDA_BIN" \
    -DCMAKE_BUILD_TYPE:STRING="$BUILD_TYPE"

cmake --build "$BUILD_DIR" --config "$BUILD_TYPE"

python3 setup.py bdist_wheel -d build83/dist
