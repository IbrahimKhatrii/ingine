/// iEngine.dart
///
/// 📦 This file is the main entry point of the **iEngine framework**.
/// It initializes Flutter bindings, sets up shared preferences, and starts the app.
/// It also re-exports core utilities such as preferences, extensions, and canvas rendering.

library;

import 'package:flutter/material.dart';
import 'iEngine/prefs.dart';

/// 🌍 Exports platform utilities.
export 'platform.dart';

/// 💾 Exports the Prefs class for global access to SharedPreferences.
export 'iEngine/prefs.dart';

/// ✨ Flutter extensions
export 'src/iEngine/extensions/build_context.dart';
export 'src/iEngine/extensions/color.dart';
export 'src/iEngine/extensions/path.dart';
export 'src/iEngine/extensions.dart';

/// 🎨 Core canvas logic
part 'iEngine/canvas/canvas.dart';
part 'iEngine/canvas/painter.dart';

/// The main class for initializing and running a Flutter app using **iEngine**.
///
/// This class ensures:
/// - Flutter binding is initialized
/// - Persistent storage (`Prefs`) is set up
/// - Your provided app widget is run
///
/// ### Example
/// ```dart
/// void main() {
///   IEngine.run(MyApp());
/// }
/// ```
class IEngine {
  /// Creates an instance of [IEngine].
  ///
  /// This class is only used to initialize and run the app using [IEngine.run].
  IEngine._(); // Prevents instantiation
  /// Initializes the iEngine environment and launches the given [application].
  ///
  /// This should be called at the very start of `main()`.
  static void run(Widget application) async {
    WidgetsFlutterBinding.ensureInitialized(); // Required for async initialization
    await Prefs.instance(); // Setup shared preferences
    runApp(application); // Start the app
  }
}
