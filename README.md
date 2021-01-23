# aksestokomobile

Akses Toko Mobile untuk mendukung versi web (liferay)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

ARM		: ARMv7 atau armeabi -> app-armeabi-v7a-prod-release
device: redmi 4a

ARM64	: AArch64 atau arm64 -> app-arm64-v8a-prod-release
device:

x86		: x86 atau x86abi -> app-x86_64-prod-release
device:

## First
flutter clean

## Target Platform
flutter build apk --flavor prod -t lib/main_qa.dart --target-platform=android-arm,android-arm64,android-x64 --split-per-abi
flutter build apk --flavor qa -t lib/main_prod.dart --target-platform=android-arm,android-arm64,android-x64 --split-per-abi

## Release
flutter run --release --flavor prod -t lib/main_prod.dart
flutter run --release --flavor serverqa -t lib/main_qa.dart
flutter run --release --flavor serverprod -t lib/main_qa_prod.dart

## Build APK
flutter build apk --flavor prod -t lib/main_prod.dart --target-platform=android-arm --split-per-abi
flutter build apk --flavor serverqa -t lib/main_qa.dart --target-platform=android-arm --split-per-abi
flutter build apk --flavor serverprod -t lib/main_qa_prod.dart --target-platform=android-arm --split-per-abi

## Build AppBundle
flutter build appbundle --flavor prod -t lib/main_prod.dart --target-platform=android-arm,android-arm64,android-x64