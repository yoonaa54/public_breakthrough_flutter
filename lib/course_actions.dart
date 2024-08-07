import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseActionsPage extends StatefulWidget {
  const CourseActionsPage({super.key});

  @override
  CourseActionsPageState createState() => CourseActionsPageState();
}

class CourseActionsPageState extends State<CourseActionsPage> {
  bool _action1Completed = false;
  bool _action2Completed = false;
  bool _action3Completed = false;

  @override
  void initState() {
    super.initState();
    _loadCheckboxStates();
  }

  Future<void> _loadCheckboxStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _action1Completed = prefs.getBool('action1') ?? false;
      _action2Completed = prefs.getBool('action2') ?? false;
      _action3Completed = prefs.getBool('action3') ?? false;
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
      body: ListView(
        children: <Widget>[
          CheckboxListTile(
            title: const Text('Action 1: Read the course overview'),
            value: _action1Completed,
            onChanged: (bool? value) {
              setState(() {
                _action1Completed = value ?? false;
                _saveCheckboxState('action1', _action1Completed);
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Action 2: Complete the first assignment'),
            value: _action2Completed,
            onChanged: (bool? value) {
              setState(() {
                _action2Completed = value ?? false;
                _saveCheckboxState('action2', _action2Completed);
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Action 3: Participate in the discussion forum'),
            value: _action3Completed,
            onChanged: (bool? value) {
              setState(() {
                _action3Completed = value ?? false;
                _saveCheckboxState('action3', _action3Completed);
              });
            },
          ),
        ],
      ),
    );
  }
}
