#!/bin/bash -eu

export PATH=/opt/ida/swig-4.0.1-py3-install/bin:${PATH}
export PATH=/opt/ida/idasdk_pro83/bin:${PATH}
export __LINUX__=1

IDA_INSTALL="/opt/ida/ida-8.3"
cp -a $IDA_INSTALL/plugins/hexrays_sdk/include/hexrays.hpp include/

if [[ ! -d plugins/idapython ]]; then 
    git clone https://github.com/idapython/src.git plugins/idapython
fi

make -j

export PYTHON_VERSION_MAJOR=3
export PYTHON_VERSION_MINOR=10

SWIG_HOME="/opt/ida/swig-4.0.1-py3-install"

cp -a $IDA_INSTALL/plugins/hexrays_sdk/include/hexrays.hpp include/

cd plugins/idapython

sed -i '/  MODULES_NAMES += mergemod/d; /  MODULES_NAMES += merge/d;' makefile

python3 build.py \
	-j \
	--with-hexrays \
	--swig-home "${SWIG_HOME}" \
	--ida-install "${IDA_INSTALL}"

exit 0


export SWIG_HOME="/opt/ida/swig-4.0.1-py3-install"
export IDA_INSTALL="/opt/ida/ida-8.2"
export OUT_OF_TREE_BUILD=1
make -j 20 NDEBUG=1 
