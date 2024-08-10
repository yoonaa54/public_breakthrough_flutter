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
    'assets/markdown/courseAction0.md',
    'assets/markdown/courseAction1.md',
    'assets/markdown/courseAction2.md',
    'assets/markdown/courseAction3.md',
  ];
  List<String> textCourseActions = List.empty(growable: true);
  List<String> actionTitles = [
    'Welcome to the course',
    'Install & Sign up to all the things',
    'Check all the things',
    'Check: is Flutter installed and working?',
  ];

  List<List<String>> buttonCopyContentLists = [
    ['echo "hello from the terminal"'],
    ['NIXPKGS_ALLOW_UNFREE=1 nix-shell'],
    [],
    [
      'pwd',
      'flutter doctor',
      'flutter create my_first_flutter_app',
      'cd my_first_flutter_app',
      'flutter run -d chrome'
    ],
  ];

  List<List<String>> buttonCopyTextLists = [
    ['Click to copy `echo "hello from the terminal"` to Clipboard'],
    ['Click to copy `NIXPKGS_ALLOW_UNFREE=1 nix-shell` to Clipboard'],
    [],
    [
      'Click to copy `pwd` to Clipboard',
      'Click to copy `flutter doctor` to Clipboard',
      'Click to copy `flutter create my_first_flutter_app` to Clipboard',
      'Click to copy `cd my_first_flutter_app` to Clipboard',
      'Click to copy `flutter run -d chrome` to Clipboard',
    ],
  ];
  late ScrollController _scrollController;

  @override
  void initState() {
    if (textCourseActions.isEmpty) {
      // To understand these next 3 lines, make them a comment
      // with // and explore what happens
      textCourseActions = List<String>.filled(assetsCourseActions.length, '');
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
        textCourseActions[i] = textCourseAction;
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
                for (int i = 0; i < assetsCourseActions.length; i++)
                  _buildCustomExpansionPanelList(
                    title: 'Action $i:\n${actionTitles[i]}',
                    action: actionsCompleted[i],
                    checkbox: 'courseAction$i',
                    index: i,
                    markdownData: textCourseActions[i],
                    buttonCopyContentList: buttonCopyContentLists[i],
                    buttonCopyTextList: buttonCopyTextLists[i],
                  ),
              ],
            )),
      ),
    );
  }

  Widget _buildCustomExpansionPanelList({
    required String title,
    required bool action,
    required String checkbox,
    required int index,
    required String markdownData,
    List<String>? buttonCopyContentList,
    List<String>? buttonCopyTextList,
  }) {
    return CustomExpansionPanelList(
      titleAlign: TextAlign.center,
      title: title,
      action: action,
      checkbox: checkbox,
      isOpen: isOpen[index],
      onExpansionChanged: (bool isExpanded) {
        setState(() {
          _loadMarkdownData();
          // reduces hot reload effort on macos
          // but not on web. Elsewhere untested
          isOpen[index] = isExpanded;
        });
      },
      onCheckboxChanged: (bool? value) {
        setState(
          () {
            actionsCompleted[index] = value ?? false;
            _saveCheckboxState(checkbox, value ?? false);
            switch (actionsCompleted[index]) {
              case true:
                isOpen[index] = false;
                break;
              case false:
                isOpen[index] = true;
                break;
            }
          },
        );
      },
      buttonCopyContentList: buttonCopyContentList,
      buttonCopyTextList: buttonCopyTextList,
      markdownData: markdownData,
    );
  }
}
