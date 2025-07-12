<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

Welcome to the IEngine Framework!
IEngine is a lightweight and beginner-friendly framework designed to simplify Flutter development by reducing boilerplate and offering a clean, intuitive structure. Whether you're building apps or packages, IEngine helps you move faster with less code and more clarity.

## 🚀 Features of iEngine

The `iEngine` framework provides a simplified and powerful foundation for building Flutter apps with minimal boilerplate. Here’s what it offers:

### ✅ Core Initialization

- Ensures `WidgetsFlutterBinding` is initialized before app launch.
- Handles shared preferences setup automatically via `Prefs.instance()`.

### 🧠 State-Free Utilities

- Access preferences globally without `async` or boilerplate.
- Simplified app entry point with `IEngine.run(MyApp());`.

### 🎯 Built-in Extensions

- `BuildContext` extensions for screen size and platform detection.
- `Color` extensions for easier color manipulation and themes.
- `Path` extensions to simplify file and route handling.

### 🎨 Custom Canvas Tools

- Includes `ICanvas` utilities and a flexible `IPainter` system.
- Easily create custom drawings and visual effects and it uses `AnimationController` for dynamic effects.

### 🌐 HTTP Support Out-of-the-box

- Built-in support for the `http` package.
- Simplifies common networking operations with `dart:convert`.

### ⚙️ Platform Aware

- Handles both mobile and desktop environments with smart checks using `Platform` and `kIsWeb`.

## 🧑‍💻 Getting Started

To start using iEngine in your Flutter project:

1. Add the package to your `pubspec.yaml`:

2. Import and use `IEngine` in your `main.dart`:

⚠️ Important:  
You must use `IEngine.run()` instead of `runApp()` to ensure Flutter bindings and shared preferences (`Prefs`) are properly initialized before your app starts.  
Skipping this may cause unexpected behavior or null values when accessing preferences.

## 🛠️ Usage

### ▶️ IEngine.run()

Use `IEngine.run()` as the entry point of your Flutter app instead of the default `runApp()`.  
This ensures proper initialization of Flutter bindings and shared preferences before the app starts.

#### ✅ Example:

```dart
import 'package:ingine/engine.dart';

void main() {
  IEngine.run(MyApp());
}
```

### 💾 Prefs

`Prefs` is a simple wrapper around `SharedPreferences` that allows easy access to persistent storage without boilerplate or needing `async` in your widgets.

It is automatically initialized when you use `IEngine.run()`.

#### ✅ Get values:

```dart
String username = Prefs.getString('username');
int score = Prefs.getInt('score');
bool isDarkMode = Prefs.getBool('dark_mode');
```

#### ✅ Set values:

```dart
await Prefs.setString('username', 'Ibrahim');
await Prefs.setInt('score', 100);
await Prefs.setBool('dark_mode', true);
```

#### ✅ utils:

```dart
Prefs.contains('username'); // Check if key exists
await Prefs.remove('username'); // Remove specific key
await Prefs.clear(); // Clear all preferences

```

### 🧩 Core Dart Extensions

The `extensions.dart` file provides handy extensions for commonly used Dart types like `String`, `num`, and `Object`, making your code cleaner and more expressive.

#### Object Extension

- **Paste Text**

```dart
final text = await Object().paste(); // or
final pastedString = await any.paste();
print('Pasted: $text');
```

#### String Extension

- **Fetch JSON from URL**

```dart
final data = await 'https://api.example.com/data'.fetchJson();
print(data['key']);
```

- **Copy to Clipboard**

```dart
'Copied text'.copyToClipboard(); // Basic usage
'Copied text'.copyToClipboard(context); // With toast message ('Copied!')
'Copied text'.copyToClipboard(context, 'Copied to clipboard!'); // With custom toast message

```

- **Email Validation**

```dart
if ('example@email.com'.isEmail) {
  print('Valid email!');
}

```

#### 🧪 Number Extension

- **Range Check**

```dart
if (value.inRange(10, 20)) {
  print('Value is between 10 and 20');
}

```

### 🖼️ BuildContext Extensions

`ContextExtensions` provides useful properties directly on `BuildContext` to help identify screen size, platform, and orientation — all without boilerplate.

#### 📏 Screen Size Checks

```dart
context.isMobile;   // true if width < 600
context.isTablet;   // true if width between 600 and 800
context.isDesktop;  // true if width > 1024
```

#### 📏 Orientation Checks

```dart
if (context.isLandscape) {
  print('Landscape mode');
} else if (context.isPortrait) {
  print('Portrait mode');
}

```

### 🎨 Color Extension

`ColorUtils` adds a simple way to adjust the brightness of any `Color` using HSL-based logic.

#### 🔆 Adjust Brightness

```dart
final baseColor = Colors.blue;

// Make the color slightly brighter
final brighter = baseColor.brightness(0.7);

// Make the color slightly darker
final darker = baseColor.brightness(0.3);
```

### ✏️ Path Extension

`PathExtension` adds a utility to draw smooth curves between a list of points using quadratic Bézier curves.

#### ➰ Add a Smooth Curve to a Path

```dart
final points = [
  Offset(0, 0),
  Offset(50, 100),
  Offset(100, 50),
  Offset(150, 150),
];

final path = Path().addSmoothCurve(points);
```

### Platforms

- Detects the platform safely using conditional imports.
- Supports:
  - ✔️ Android
  - ✔️ iOS
  - ✔️ Web
  - ✔️ Windows
  - ✔️ macOS
  - ✔️ Linux
- Avoids using `dart:io` on Web or unsupported platforms like WASM.

---

#### Usage

```dart
import 'package:ingine/platform.dart';

if (isWeb) {
  print("Running on Web");
} else if (isAndroid) {
  print("Running on Android");
} else if (isIOS) {
  print("Running on iOS");
} else if (isWindows) {
  print("Running on Windows");
}
```

### 🖌️ ICanvas & IPainter

The `ICanvas` widget and `IPainter` class provide a lightweight framework for building animated, interactive custom canvas drawings using `CustomPaint`, animation controllers, and reusable rendering logic.

---

#### 🎨 How It Works

- `ICanvas` is a widget that wraps `CustomPaint` and handles:
  - Canvas size tracking
  - Re-initializing on resize
  - Animation control via `ValueNotifier`
- `IPainter` is an abstract base class where you:
  - Set up animations
  - Override the `render` method to draw on the canvas
  - Manage lifecycle (init, update, dispose)

---

#### ✅ Example Usage

```dart
class MyEffect extends IPainter {
  late AnimationController _controller;
  late Animation<double> _radius;

  @override
  void onInit(TickerProvider vsync) {
    _controller = createController(
      vsync: vsync,
      duration: const Duration(seconds: 2),
      repeat: true,
    );

    _radius = createAnimation(
      vsync: vsync,
      controller: _controller,
      tween: Tween<double>(begin: 0, end: 100),
      listener: update,
    );
  }

  @override
  void render(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawCircle(center, _radius.value, paint);
  }
}
```

## 📦 Additional Information

For more details, documentation, and updates, visit the official repository:

🔗 GitHub: [https://github.com/IbrahimKhatrii/ingine](https://github.com/IbrahimKhatrii/ingine)

### 🤝 Contributing

Contributions are welcome!
If you'd like to contribute to `iEngine`, feel free to fork the repository, make your changes, and submit a pull request. Please follow existing code style and conventions.

### 🐞 Issues & Feedback

Found a bug or have a feature request?
Please open an issue on the GitHub repository. We actively monitor and try to respond quickly to all issues and suggestions.

### 📬 Contact

If you have any questions or need help using the package, reach out via the Issues section or discussions tab on GitHub.

---

Thanks for using **iEngine** – A lightweight and developer-friendly way to power your Flutter apps!
