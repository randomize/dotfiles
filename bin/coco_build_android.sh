#!/bin/bash
# Base building script
# Randomize, 2013
set -e

export NDK_TOOLCHAIN_VERSION=4.8
export NDK_ROOT=~/android/ndk
export ANDROID_SDK_ROOT=~/android/sdk
export COCOS2DX_ROOT=~/cocos2d-x

export PATH="${PATH}:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools"

python -c 'import os; print( os.environ[ "ANDROID_SDK_ROOT" ])'

cd ./proj.android

python2 ./build_native.py

android update project -p ./ -t 1
android update project -p ../../../cocos/2d/platform/android/java/ -t 1

ant debug
ant installd

