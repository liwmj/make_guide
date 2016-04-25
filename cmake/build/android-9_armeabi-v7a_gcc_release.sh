#!/usr/bin/env bash

mkdir -p ${PWD}/../../build/cmake_android-9_armeabi-v7a_gcc_release/
cd ${PWD}/../../build/cmake_android-9_armeabi-v7a_gcc_release/
rm -rf *

../../cmake/toolchain/android-ndk-r8/build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.4.3 --platform=android-9 --system=linux-x86 --ndk-dir=../../cmake/toolchain/android-ndk-r8/ --install-dir=${PWD}
#../../cmake/toolchain/android-ndk-r8/build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.4.3 --platform=android-9 --system=darwin-x86_64 --ndk-dir=../../cmake/toolchain/android-ndk-r8/ --install-dir=${PWD}

export PATH=${PWD}/bin:$PATH
export ANDROID_STANDALONE_TOOLCHAIN=${PWD}

cmake -DCPLATFORM=android-9 -DCCPU=armeabi-v7a -DCCOMPILE=gcc -DCVER=release -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../../cmake/toolchain/android.toolchain.cmake -DANDROID_NATIVE_API_LEVEL="android-9" -DANDROID_ABI="armeabi-v7a with NEON" ../../cmake
#make -j8
cmake --build .

exit 0
