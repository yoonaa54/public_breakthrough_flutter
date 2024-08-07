import 'package:flutter/material.dart';
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
  final String _markdownData = '''
## Course Actions
- Action 1: Read the course overview
- Action 2: Complete the first assignment
- Action 3: Participate in the discussion forum
''';

  @override
  void initState() {
    super.initState();
    _loadCheckboxStates();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Actions'),
      ),
      body: Column(
        children: [
          CustomExpansionPanelList(
            title: 'Action 1: Read the course overview',
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
            markdownData: _markdownData,
          ),
        ],
      ),
    );
  }
}
