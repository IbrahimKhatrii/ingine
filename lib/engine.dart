// iEngine.dart
//
// 📦 This file is the main entry point of the iEngine framework.
// It initializes Flutter bindings, sets up shared preferences, and starts the app.
// It also exposes core utilities such as preferences and extensions etc.

library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http; // http (required)
import 'dart:convert';

import 'iEngine/prefs.dart';

export 'iEngine/prefs.dart'; // Export Prefs for global access

part 'iEngine/extensions.dart';

// Flutter extensions
part 'iEngine/extensions/build_context.dart';
part 'iEngine/extensions/color.dart';
part 'iEngine/extensions/path.dart';

// Utils
part 'iEngine/canvas/canvas.dart';
part 'iEngine/canvas/painter.dart';

/// The main class for initializing and running a Flutter app using iEngine.
///
/// This class ensures proper initialization of required components before launching the app.
/// - Ensures Flutter binding is initialized.
/// - Prepares persistent storage using `Prefs`.
/// - Runs the provided `Widget` application.
class IEngine {
  /// Call this method in your `main()` to start the app.
  ///
  /// Example:
  /// ```dart
  /// void main() {
  ///   IEngine.run(MyApp());
  /// }
  /// ```
  static void run(Widget application) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Prefs.instance();
    runApp(application);
  }
}
