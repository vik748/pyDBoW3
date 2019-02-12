#!/bin/bash

set -x

cd ${0%%$(basename $0)}
mkdir build
cd build

if [[ "$OSTYPE" == "linux-gnu" || "$OSTYPE" == "linux" ]]; then
    cmake -DBUILD_PYTHON3=ON -DDBoW3_LIBRARY=../../DBoW3/lib/libDBoW2.so -DCMAKE_BUILD_TYPE=Release ../src && make
elif [[ "$OSTYPE" == "darwin"* ]]; then
    PYTHON_VERSION=`python -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";`
    PYTHON_LIBRARY=/usr/local/Frameworks/Python.framework/Versions/$PYTHON_VERSION/lib/libpython$PYTHON_VERSION.dylib
    PYTHON_INCLUDE_DIR=/usr/local/Frameworks/Python.framework/Versions/$PYTHON_VERSION/Headers/
    cmake -DPYTHON_LIBRARY=$PYTHON_LIBRARY -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR -DCMAKE_BUILD_TYPE=RELEASE ../src && make
elif [[ "$OSTYPE" == "cygwin" ]]; then
    : # POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
    : # shell and GNU utilities compiled for Windows as part of MinGW
elif [[ "$OSTYPE" == "win32" ]]; then
    : # good luck
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    : # ...
else
    : # Unknown.
fi