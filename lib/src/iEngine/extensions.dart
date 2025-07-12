import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

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

// part of '../../engine.dart';

/// Extension on [Object] to provide common clipboard-related utilities.
///
/// Although declared on `Object`, it is primarily intended for use in
/// UI classes or utility logic where access to clipboard is needed.
extension ObjectExtension on Object {
  /// Reads and returns plain text from the system clipboard.
  ///
  /// Returns an empty string if the clipboard is empty or `null`.
  ///
  /// Example:
  /// ```dart
  /// final text = await someObject.paste();
  /// print(text);
  /// ```
  Future<String> paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    return data?.text ?? '';
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

  /// Copies this string to the clipboard.
  ///
  /// If a [BuildContext] is provided, it will also show a [SnackBar]
  /// with the given [message], or "Copied!" by default.
  void copyToClipboard([BuildContext? context, String? message]) {
    Clipboard.setData(ClipboardData(text: this));
    if (context != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message ?? 'Copied!')));
    }
  }

  /// Returns `true` if this string is a valid email address format.
  ///
  /// Uses a simple regular expression to validate the pattern:
  /// - local part (alphanumeric, dot, or hyphen)
  /// - '@' symbol
  /// - domain part (alphanumeric, dot, or hyphen)
  /// - ends with a valid top-level domain (2+ characters)
  bool get isEmail {
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
    return emailRegex.hasMatch(this);
  }
}

/// Extension on [num] to add range checking capabilities.
extension NumRangeCheck on num {
  /// Returns `true` if this number is within the inclusive range
  /// between [min] and [max].
  ///
  /// Example:
  /// ```dart
  /// 5.inRange(1, 10); // true
  /// 0.inRange(1, 10); // false
  /// ```
  bool inRange(num min, num max) => this >= min && this <= max;
}
