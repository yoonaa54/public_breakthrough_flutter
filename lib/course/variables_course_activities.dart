List<String> assetsCourseActivities = [
  // TODO: this list could be refactored into
  // mapCourseActivities
  'assets/markdown/courseActivity0.md',
  'assets/markdown/courseActivity1.md',
  'assets/markdown/courseActivity2.md',
  'assets/markdown/courseActivity3.md',
  'assets/markdown/courseActivity4.md',
  'assets/markdown/courseActivity5.md',
  'assets/markdown/courseActivity6.md',
  'assets/markdown/courseActivity7.md',
  'assets/markdown/courseActivity8.md',
  'assets/markdown/courseActivity9.md',
];
// TODO: If we define this list here, it changes the behaviour
// and on second pass we get a RangeError
// List<String> textOfCourseActivities = List.empty(growable: true);

Map<String, Map<String, List<String>>> mapCourseActivities = {
  'Day 1 - Welcome to Week 9!': {
    'buttonCopyContent': ['echo "hello from the terminal"'],
    'buttonCopyText': [
      'Click to copy `echo "hello from the terminal"` to Clipboard'
    ],
  },
  'Install & Sign up to all the things': {
    'buttonCopyContent': ['NIXPKGS_ALLOW_UNFREE=1 nix-shell'],
    'buttonCopyText': [
      'Click to copy `NIXPKGS_ALLOW_UNFREE=1 nix-shell` to Clipboard'
    ],
  },
  'Check: all the things': {
    'buttonCopyContent': ['NIXPKGS_ALLOW_UNFREE=1 nix-shell'],
    'buttonCopyText': [
      'Click to copy `NIXPKGS_ALLOW_UNFREE=1 nix-shell` to Clipboard'
    ],
  },
  'Check: is Flutter installed and working?': {
    'buttonCopyContent': [
      'NIXPKGS_ALLOW_UNFREE=1 nix-shell',
      'pwd',
      'flutter doctor',
      'flutter create my_first_flutter_app',
      'cd my_first_flutter_app',
      'flutter run -d chrome'
    ],
    'buttonCopyText': [
      'Click to copy `NIXPKGS_ALLOW_UNFREE=1 nix-shell` to Clipboard',
      'Click to copy `pwd` to Clipboard',
      'Click to copy `flutter doctor` to Clipboard',
      'Click to copy `flutter create my_first_flutter_app` to Clipboard',
      'Click to copy `cd my_first_flutter_app` to Clipboard',
      'Click to copy `flutter run -d chrome` to Clipboard',
    ],
  },
  'Check: are git & GitHub installed, configured and working?': {
    'buttonCopyContent': ['git --version'],
    'buttonCopyText': ['Click to copy `git --version` to Clipboard'],
  },
  'Check: is VSCode installed and working?': {
    'buttonCopyContent': [
      'code',
      'code --install-extension codeium.codeium',
      'code --install-extension dart-code.flutter@3.92.0',
    ],
    'buttonCopyText': [
      'Click to copy `code` to Clipboard',
      'Click to copy `code --install-extension codeium.codeium` to Clipboard',
      'Click to copy `code --install-extension dart-code.flutter@3.92.0` to Clipboard',
    ],
  },
  'Implementation: Website Deployment': {
    'buttonCopyContent': [
      'make test',
      'make deploy OUTPUT=cv_demo',
    ],
    'buttonCopyText': [
      'Click to copy `make test` to Clipboard',
      'Click to copy `make deploy OUTPUT=cv_demo` to Clipboard'
    ],
  },
  'Exploration: VSCode plugins': {},
  'Day 2 - HTML CV creation': {},
  'Calandly integration': {},
};
