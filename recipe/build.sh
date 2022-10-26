#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./bin/scripts

export CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-std=c++17/-std=c++14/g")

mkdir build
autoconf

if [[ "$host_alias" != "$build_alias" ]]
then
  CONFIGURE_CROSS_OPTIONS="--host=$host_alias --build=$build_alias"
fi


cd build
../configure --prefix=$PREFIX $CONFIGURE_CROSS_OPTIONS \ \
             --with-openssl \
             --with-omniorb=$PREFIX
make -j$CPU_COUNT
make install
