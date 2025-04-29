#!/bin/bash

# Start emulator if not already running
if ! adb devices | grep emulator; then
    echo "Starting Emulator..."
    nohup emulator -avd pixel6a_avd -gpu swiftshader_indirect -memory 1024 -no-boot-anim > /dev/null 2>&1 &
    echo "Waiting for emulator to boot..."
    boot_completed=""
    until [[ "$boot_completed" == "1" ]]; do
        sleep 5
        boot_completed=$(adb shell getprop sys.boot_completed 2>/dev/null | tr -d '\r')
    done
    echo "Emulator is ready!"
else
    echo "Emulator already running."
fi

# Pre-build Flutter app if needed
echo "Cleaning Flutter project..."
flutter clean

echo "Fetching packages..."
flutter pub get

echo "Prebuilding APK (debug)..."
flutter build apk --debug

# Now run the app
echo "Launching Flutter app..."
flutter run
