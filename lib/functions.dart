import 'package:flutter/services.dart' show rootBundle;

Future<String> readMarkdownFromAssets(String filename) async {
  try {
    String contents = await rootBundle.loadString(filename);
    return contents;
  } catch (e) {
    // Handle any errors that occur during file reading
    print("Error reading file: $e");
    return '';
  }
}
