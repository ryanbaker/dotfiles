# .profile
# Add some more custom software to PATH.
PATH=$PATH:/opt/local/bin:/usr/local/sbin:$HOME/bin
# Android
export ANDROID_SDK=$HOME/dev/android/adt-bundle-mac-x86_64-20130522/sdk
export ANDROID_NDK=$HOME/dev/android/android-ndk-r8e
PATH=$PATH:${ANDROID_SDK}/tools:${ANDROID_SDK}/platform-tools:${ANDROID_NDK}
# arm-none-eabi-gcc
PATH=$PATH:$HOME/gcc/arm-none-eabi-gcc/bin
# Export PATH
export PATH
