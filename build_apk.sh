#!/bin/bash
set -o pipefail
export PATH=/opt/flutter-sdk/bin:/opt/android-sdk/cmdline-tools/latest/bin:$PATH
export ANDROID_SDK_ROOT=/opt/android-sdk
export ANDROID_HOME=/opt/android-sdk
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export CI=true
export DEBIAN_FRONTEND=noninteractive

echo "=== [1/4] Flutter pub get ==="
cd /tmp/Operit2/apps/flutter/app
flutter pub get 2>&1
echo "=== [2/4] Prebuild Rust for arm64-v8a ==="
# Rust 编译 bridge native lib，Flutter build 会自动触发
echo "=== [3/4] Flutter build apk (arm64-v8a only) ==="
flutter build apk --target-platform android-arm64 --release 2>&1
echo "=== [4/4] Copy APK ==="
cp /tmp/Operit2/apps/flutter/app/build/app/outputs/flutter-apk/app-release.apk /sdcard/Download/operit2-arm64-v8a.apk 2>/dev/null && echo "=== APK copied to /sdcard/Download/operit2-arm64-v8a.apk ===" || echo "=== APK copy failed, check build output ==="
ls -lh /sdcard/Download/operit2-arm64-v8a.apk 2>/dev/null
echo "=== DONE ==="
