import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformAssetBundle;
// import 'package:flutter/services.dart' show rootBundle;

Future<String> readMarkdownFromAssets(
    BuildContext context, String filename) async {
  try {
    final assetBundle = PlatformAssetBundle();
    // String contents = await rootBundle.loadString(filename, cache: false);
    String contents = await assetBundle.loadString(filename, cache: false);
    // cache faluse doesn't appear to work, need to trigger hot reload to work
    // assetBundle.clear();
    return contents;
  } catch (e) {
    print("Error reading file in readMarkdownFromAssets: $e");
    return '';
  }
}
