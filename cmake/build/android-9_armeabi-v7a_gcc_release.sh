#!/usr/bin/env bash

PROJECT_NAME="cmake"
ANDROID_NDK="${PWD}/../../${PROJECT_NAME}/toolchain/android-ndk-r8/"

CPLATFORM="android-9"
CCPU="armeabi-v7a"
CCOMPILE="gcc"
CVER="release"

mkdir -p ${PWD}/../../build/${PROJECT_NAME}_${CPLATFORM}_${CCPU}_${CCOMPILE}_${CVER}/
cd ${PWD}/../../build/${PROJECT_NAME}_${CPLATFORM}_${CCPU}_${CCOMPILE}_${CVER}/
rm -rf *

${ANDROID_NDK}/build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.4.3 --system=linux-x86 --platform=${CPLATFORM} --ndk-dir=${ANDROID_NDK} --install-dir=${PWD}
#${ANDROID_NDK}/build/tools/make-standalone-toolchain.sh --toolchain=arm-linux-androideabi-4.4.3 --system=darwin-x86_64 --platform=${CPLATFORM} --ndk-dir=${ANDROID_NDK} --install-dir=${PWD}

export PATH=${PWD}/bin/:$PATH
export PATH=${ANDROID_NDK}/build/tools/:$PATH
export ANDROID_STANDALONE_TOOLCHAIN=${PWD}

cmake -DCPLATFORM=${CPLATFORM} -DCCPU=${CCPU} -DCCOMPILE=${CCOMPILE} -DCVER=${CVER} -DANDROID_ABI="${CCPU} with NEON" -DANDROID_NATIVE_API_LEVEL=${CPLATFORM} -DCMAKE_BUILD_TYPE=${CVER} -DCMAKE_TOOLCHAIN_FILE=../../${PROJECT_NAME}/toolchain/android.toolchain.cmake ../../${PROJECT_NAME}
#make -j8
cmake --build .

exit 0
