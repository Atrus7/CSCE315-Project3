#!/bin/bash
# build project3. should be run in root of project.
# USAGE: cd $PROJECT_ROOT; ./build.sh

# if [ "$1" == "-v" ]; then
# VERBOSE_MAKE=1
# else
# VERBOSE_MAKE=0
# fi

# get username
USER=`whoami`
# get os
UNAME=`uname`
# get hostname
if [ "$UNAME" = "Darwin" ]; then
    # if os x
    HOSTNAME=`hostname -s`
else
    # if not os x
    HOSTNAME=`hostname`
fi

# set number of cores for each server
# set compilers
if [ "$HOSTNAME" = "sun2.cs.tamu.edu" ]; then
    CORES=8
elif [ "$HOSTNAME" = "compute-linux1" ]; then
    # hell yeah
    CORES=32
    CC=/usr/bin/gcc-4.7
    CXX=/usr/bin/g++-4.7
elif [ "$HOSTNAME" = "Tron" ]; then
    CORES=4
    CXX="/usr/local/opt/ccache/libexec/clang++-3.6 -stdlib=libc++"
    CXXFLAGS="$CXXFLAGS -nostdinc++ -I/usr/local/opt/llvm36/lib/llvm-3.6/include/c++/v1"
    LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm36/lib/llvm-3.6/lib"
else
    CORES=4
fi

# set some directories and files
PROJECT_ROOT_DIR=`pwd`

# compile FLAGS
LOCAL_LIBS=$PROJECT_ROOT_DIR/local/lib
CC=${CC} CXX=${CXX} LD_LIBRARY_PATH=${LOCAL_LIBS}


RELEASE_BUILD_DIR="build"
DEBUG_BUILD_DIR="debug"

echo "Starting Release Build..."

# create and switch to build dir
if [ ! -d "$RELEASE_BUILD_DIR" ]; then
    mkdir "$RELEASE_BUILD_DIR";
    cd "$RELEASE_BUILD_DIR";
    # generate release build make files
    CC=${CC} CXX=${CXX} LD_LIBRARY_PATH=${LOCAL_LIBS} cmake -DCMAKE_BUILD_TYPE=Release ..
    # make on all cores
    # VERBOSE=${VERBOSE_MAKE} make -j"$CORES"
    make -j"$CORES"
    # get return code
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        echo "Release Build Failed"
        exit 1
    fi
else
    echo "Running make clean in $RELEASE_BUILD_DIR"
    cd "$RELEASE_BUILD_DIR"
    make clean
    # VERBOSE=${VERBOSE_MAKE} make -j"$CORES"
    make -j"$CORES"
    # get return code
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        echo "Release Build Failed"
        exit 1
    fi
fi
echo "Release Build Done!"

echo "Starting Debug Build..."

# cd back to project root
cd ..
# create and switch to build dir
if [ ! -d "$DEBUG_BUILD_DIR" ]; then
    mkdir "$DEBUG_BUILD_DIR";
    cd "$DEBUG_BUILD_DIR";
    # generate debug build make files
    CC=${CC} CXX=${CXX} LD_LIBRARY_PATH=${LOCAL_LIBS} cmake -DCMAKE_BUILD_TYPE=Debug ..
    # make on all cores
    # VERBOSE=${VERBOSE_MAKE} make -j"$CORES"
    make -j"$CORES"
    # get return code
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        echo "Debug Build Failed"
        exit 1
    fi
else
    echo "Running make clean in $DEBUG_BUILD_DIR"
    cd "$RELEASE_BUILD_DIR"
    make clean
    # VERBOSE=${VERBOSE_MAKE} make -j"$CORES"
    make -j"$CORES"
    # get return code
    RESULT=$?
    if [ $RESULT -ne 0 ]; then
        echo "Debug Build Failed"
        exit 1
    fi
fi
echo "Debug Build Done!"

# cd back to project root
cd ..

echo "Release Build PROJECT_ROOT/$RELEASE_BUILD_DIR/"
echo "Debug Build PROJECT_ROOT/$DEBUG_BUILD_DIR/"
exit 0
