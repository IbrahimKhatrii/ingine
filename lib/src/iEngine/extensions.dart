/// This file: `extensions.dart`
///
/// Contains only **core Dart type extensions**, such as:
/// - `String`
/// - `int`
/// - `bool`
/// - and other primitive types.
///
/// This file acts as a **central aggregator**, connecting and exporting
/// all related extension files to ensure consistent and easy access across the project.
/// it is the 'part of' engine.dart

part of '../../engine.dart';

extension ObjectExtension on Object {
  Future<String?> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data == null ? '' : data.text;
  }
}

/// An extension on [String] that adds utility methods for network operations.
extension StringExtension on String {
  /// Fetches and decodes JSON data from the URL represented by this string.
  ///
  /// This method assumes that the string is a valid URL.
  /// It performs an HTTP GET request to the specified URL,
  /// then decodes the response body as JSON using `json.decode`.
  ///
  /// ### Example
  /// ```dart
  /// final jsonData = await 'https://api.example.com/data'.fetchJson();
  /// print(jsonData['key']);
  /// ```
  ///
  /// ### Returns
  /// A `Future<dynamic>` that completes with the decoded JSON object,
  /// which could be a `Map<String, dynamic>` or a `List`, depending on the response.
  ///
  /// ### Throws
  /// - [FormatException] if the response body is not valid JSON.
  /// - [http.ClientException] or other exceptions if the HTTP request fails.
  Future<dynamic> fetchJson() async {
    final response = await http.get(Uri.parse(this));

    // You may optionally want to check status code here before decoding
    // For example:
    // if (response.statusCode != 200) {
    //   throw Exception('Failed to load JSON: ${response.statusCode}');
    // }

    return json.decode(response.body);
  }

  void copyToClipboard([BuildContext? context, String? message]) {
    Clipboard.setData(ClipboardData(text: this));
    if (context != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message ?? 'Copied!')));
    }
  }

  bool get isEmail {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    return emailRegex.hasMatch(this);
  }
}

extension NumRangeCheck on num {
  bool inRange(num min, num max) => this >= min && this <= max;
}
