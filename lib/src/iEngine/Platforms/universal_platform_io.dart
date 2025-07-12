import 'dart:io' show Platform;

/// Returns `true` if running in a web environment.
///
/// Always returns `false` because `dart:io` is not supported on the web.
// ignore: comment_references
/// Use [kIsWeb] from `package:flutter/foundation.dart` for actual web detection in Flutter.
bool get isWeb => false;

/// Returns `true` if running on an Android device.
bool get isAndroid => Platform.isAndroid;

/// Returns `true` if running on an iOS device.
bool get isIOS => Platform.isIOS;

/// Returns `true` if running on a Windows desktop system.
bool get isWindows => Platform.isWindows;

/// Returns `true` if running on a Linux desktop system.
bool get isLinux => Platform.isLinux;

/// Returns `true` if running on a macOS desktop system.
bool get isMacOS => Platform.isMacOS;
