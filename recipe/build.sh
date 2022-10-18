#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./bin/scripts

export CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-std=c++17/-std=c++14/g")

mkdir build
autoconf
cd build
../configure --prefix=$PREFIX \
             --with-openssl \
             --with-omniorb=$PREFIX
make -j$CPU_COUNT
make install
