#!/bin/bash -eu

BUILD_DIR=build83
BUILD_TYPE=Release
IDASDK_ROOT="/opt/ida/idasdk_pro83"
IDA_BIN="/opt/ida/ida-8.3"

rm -rf "${BUILD_DIR}"

(
  cd third_party/binaryninja_api && ./regenerate-api-stubs.sh $HOME/Source/binaryninja-api
)

cmake -B "$BUILD_DIR" \
    -G Ninja -S . \
    -DBINEXPORT_ENABLE_IDAPRO=ON \
    -DBINEXPORT_ENABLE_BINARYNINJA=ON \
    -DCMAKE_INSTALL_PREFIX="${PWD}/${BUILD_DIR}" \
    -DIdaSdk_ROOT_DIR:STRING="$IDASDK_ROOT" \
    -DCMAKE_BUILD_TYPE:STRING="$BUILD_TYPE"


cmake --build "$BUILD_DIR" --config "$BUILD_TYPE"

echo ctest --build-config Release --output-on-failure
echo cmake --install . --config Release --strip
