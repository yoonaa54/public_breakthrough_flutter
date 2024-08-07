import 'package:flutter/material.dart';

class CourseActionsPage extends StatelessWidget {
  const CourseActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Actions'),
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Action 1: Read the course overview'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Action 2: Complete the first assignment'),
          ),
          ListTile(
            leading: Icon(Icons.check),
            title: Text('Action 3: Participate in the discussion forum'),
          ),
          // Add more ListTile widgets as needed
        ],
      ),
    );
  }
}
