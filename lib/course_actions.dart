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
  List<bool> isOpen = [false, false];
  List<bool> actionsCompleted = [false, false];
  List<String> assetsCourseActions = [
    'assets/markdown/courseAction0.md',
    'assets/markdown/courseAction1.md'
  ];
  List<String> textCourseActions = List.empty(growable: true);
  late ScrollController _scrollController;

  @override
  void initState() {
    if (textCourseActions.isEmpty) {
      // To understand this next line, make it a comment
      // with // and explore what happens
      textCourseActions = List<String>.filled(assetsCourseActions.length, '');
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
        // print('entered _loadMarkdownData try block...');
        var textCourseAction =
            await readMarkdownFromAssets(assetsCourseActions[i].toString());
        textCourseActions[i] = textCourseAction;
        // print('exiting _loadMarkdownData try block without encountering exceptions');
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
              _buildCustomExpansionPanelList(
                title: 'Action 0:\n Welcome to the course - Click me!',
                action: actionsCompleted[0],
                checkbox: 'courseAction0',
                index: 0,
                markdownData: textCourseActions[0],
              ),
              _buildCustomExpansionPanelList(
                title: 'Action 1:\nInstall & Sign up to all the things',
                action: actionsCompleted[1],
                checkbox: 'courseAction1',
                index: 1,
                markdownData: textCourseActions[1],
                buttonCopyContent: 'NIXPKGS_ALLOW_UNFREE=1 nix-shell',
                buttonCopyText:
                    'Click to copy `NIXPKGS_ALLOW_UNFREE=1 nix-shell` to Clipboard',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomExpansionPanelList({
    required String title,
    required bool action,
    required String checkbox,
    required int index,
    required String markdownData,
    String? buttonCopyContent,
    String? buttonCopyText,
  }) {
    return CustomExpansionPanelList(
      titleAlign: TextAlign.center,
      title: title,
      action: action,
      checkbox: checkbox,
      isOpen: isOpen[index],
      onExpansionChanged: (bool isExpanded) {
        setState(() {
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
      buttonCopyContent: buttonCopyContent,
      buttonCopyText: buttonCopyText,
      markdownData: markdownData,
    );
  }
}
