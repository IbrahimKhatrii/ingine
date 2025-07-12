/// Provides platform detection utilities (web, Android, iOS, etc.)
///
/// Use it to check platform conditions like:
/// ```dart
/// if (isWeb) { ... }
/// if (isAndroid) { ... }
/// ```
// ignore: unnecessary_library_name
library platform;

export 'src/iEngine/Platforms/stub/universal_platform_stub.dart'
    if (dart.library.io) 'src/iEngine/Platforms/universal_platform_io.dart'
    if (dart.library.html) 'src/iEngine/Platforms/stub/universal_platform_web.dart';
