import 'package:flutter/services.dart' show rootBundle;

Future<String> readMarkdownFromAssets(String filename) async {
  try {
    String contents = await rootBundle.loadString(filename);
    return contents;
  } catch (e) {
    print("Error reading file in readMarkdownFromAssets: $e");
    return '';
  }
}
