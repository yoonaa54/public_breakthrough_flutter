import 'package:flutter/material.dart';
import 'package:my_flutter_app/functions.dart';
import 'package:my_flutter_app/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_widgets.dart';

class CourseActionsPage extends StatefulWidget {
  const CourseActionsPage({super.key});

  @override
  CourseActionsPageState createState() => CourseActionsPageState();
}

class CourseActionsPageState extends State<CourseActionsPage> {
  List<bool> isOpen = List.empty(growable: true);
  List<bool> actionsCompleted = List.empty(growable: true);
  List<String> assetsCourseActions = [
    // TODO: this list could be refactored into
    // mapCourseActions
    'assets/markdown/courseAction0.md',
    'assets/markdown/courseAction1.md',
    'assets/markdown/courseAction2.md',
    'assets/markdown/courseAction3.md',
    'assets/markdown/courseAction4.md',
    'assets/markdown/courseAction5.md',
  ];
  List<String> textOfCourseActions = List.empty(growable: true);

  Map<String, Map<String, List<String>>> mapCourseActions = {
    'Welcome to the course': {
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
    'Check all the things': {
      'buttonCopyContent': [],
      'buttonCopyText': [],
    },
    'Check: is Flutter installed and working?': {
      'buttonCopyContent': [
        'pwd',
        'flutter doctor',
        'flutter create my_first_flutter_app',
        'cd my_first_flutter_app',
        'flutter run -d chrome'
      ],
      'buttonCopyText': [
        'Click to copy `pwd` to Clipboard',
        'Click to copy `flutter doctor` to Clipboard',
        'Click to copy `flutter create my_first_flutter_app` to Clipboard',
        'Click to copy `cd my_first_flutter_app` to Clipboard',
        'Click to copy `flutter run -d chrome` to Clipboard',
      ],
    },
    'Check: are git & GitHub installed, configured and working?': {
      'buttonCopyContent': [],
      'buttonCopyText': [],
    },
    'Check: is VSCode installed and working?': {
      'buttonCopyContent': [],
      'buttonCopyText': [],
    },
  };

  late ScrollController _scrollController;

  @override
  void initState() {
    if (textOfCourseActions.isEmpty) {
      // To understand these next 3 lines, make them a comment
      // with // and explore what happens
      textOfCourseActions = List<String>.filled(assetsCourseActions.length, '');
      actionsCompleted = List<bool>.filled(assetsCourseActions.length, false);
      isOpen = List<bool>.filled(assetsCourseActions.length, false);
    }
    super.initState();
    _loadCheckboxStates();
    _loadMarkdownData();
    _scrollController = ScrollController();
  }

  Future<void> _loadMarkdownData() async {
    print('assetsCourseActions length: ${assetsCourseActions.length}');
    for (int i = 0; i < assetsCourseActions.length; i++) {
      print(
          'i is: $i and assetsCourseActions[$i] is: ${assetsCourseActions[i]}');
      try {
        var textCourseAction =
            await readMarkdownFromAssets(assetsCourseActions[i].toString());
        textOfCourseActions[i] = textCourseAction;
      } catch (e) {
        print("Error reading file in readMarkdownFromAssets: $e");
      }
    }
  }

  Future<void> _loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < assetsCourseActions.length; i++) {
        actionsCompleted[i] = prefs.getBool('courseAction$i') ?? false;
      }
    });
  }

  Future<void> _saveCheckboxState(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: courseActionsPageTitle,
      ),
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              for (var i = 0; i < mapCourseActions.entries.length; i++)
                CustomExpansionPanelList(
                  titleAlign: TextAlign.center,
                  title:
                      'Action $i:\n${mapCourseActions.entries.elementAt(i).key}',
                  action: actionsCompleted[i],
                  checkbox: 'courseAction$i',
                  isOpen: isOpen[i],
                  onExpansionChanged: (bool isExpanded) {
                    setState(() {
                      _loadMarkdownData();
                      // reduces hot reload effort on MacOs
                      // but not on web. Elsewhere untested
                      isOpen[i] = isExpanded;
                    });
                  },
                  onCheckboxChanged: (bool? value) {
                    setState(() {
                      actionsCompleted[i] = value ?? false;
                      _saveCheckboxState('courseAction$i', value ?? false);
                      switch (actionsCompleted[i]) {
                        case true:
                          isOpen[i] = false;
                          break;
                        case false:
                          isOpen[i] = true;
                          break;
                      }
                    });
                  },
                  buttonCopyContentList: mapCourseActions.entries
                          .elementAt(i)
                          .value['buttonCopyContent'] ??
                      [],
                  buttonCopyTextList: mapCourseActions.entries
                          .elementAt(i)
                          .value['buttonCopyText'] ??
                      [],
                  markdownData: textOfCourseActions[i],
                )
            ],
          ),
        ),
      ),
    );
  }
}
