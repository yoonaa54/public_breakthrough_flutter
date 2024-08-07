import 'package:flutter/material.dart';
import 'package:my_flutter_app/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_widgets.dart';

class CourseActionsPage extends StatefulWidget {
  const CourseActionsPage({super.key});

  @override
  CourseActionsPageState createState() => CourseActionsPageState();
}

class CourseActionsPageState extends State<CourseActionsPage> {
  List<bool> isOpen = [false];
  bool _action0Completed = false;
  String courseAction0 = '';
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loadCheckboxStates();
    _loadMarkdownData();
    _scrollController = ScrollController();
  }

  Future<void> _loadMarkdownData() async {
    var cA0 = await readMarkdownFromAssets('assets/markdown/courseAction0.md');
    setState(() {
      courseAction0 = cA0;
    });
  }

  Future<void> _loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _action0Completed = prefs.getBool('action0') ?? false;
    });
  }

  Future<void> _saveCheckboxState(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    _loadMarkdownData(); // Note: Consider moving this to initState to avoid redundant calls.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Actions'),
      ),
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          // Wrap with a scrollable widget
          controller: _scrollController,
          child: Column(
            children: [
              CustomExpansionPanelList(
                titleAlign: TextAlign.center,
                title:
                    'Action 0: Install & Sign up to all the things - Click text to expand; Click checkbox once complete.',
                action: _action0Completed,
                checkbox: 'action0',
                isOpen: isOpen[0],
                onExpansionChanged: (bool isExpanded) {
                  setState(() {
                    isOpen[0] = isExpanded;
                  });
                },
                onCheckboxChanged: (bool? value) {
                  setState(() {
                    _action0Completed = value ?? false;
                    _saveCheckboxState('action0', _action0Completed);
                  });
                },
                buttonCopyContent: 'NIXPKGS_ALLOW_UNFREE=1 nix-shell',
                buttonCopyText:
                    'Copy `NIXPKGS_ALLOW_UNFREE=1 nix-shell` to Clipboard',
                markdownData: courseAction0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
