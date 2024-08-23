import 'package:flutter/material.dart';
import 'package:my_flutter_app/common/custom_widgets.dart';

class CVPage extends StatelessWidget {
  final String name;
  final String contactInfo;
  final String objective;
  final String education;
  final String workExperience;
  final String skills;
  final String achievements;

  const CVPage({
    super.key,
    required this.name,
    required this.contactInfo,
    required this.objective,
    required this.education,
    required this.workExperience,
    required this.skills,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Contact Info
              Card(
                color: Theme.of(context).cardColor,
                // color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(contactInfo),
                ),
              ),
              const SizedBox(height: 16),

              // Objective
              Card(
                color: Theme.of(context).cardColor,
                // color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(objective),
                ),
              ),
              const SizedBox(height: 16),

              // Education
              Card(
                color: Theme.of(context).cardColor,
                // color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(education),
                ),
              ),
              const SizedBox(height: 16),

              // Work Experience
              Card(
                color: Theme.of(context).cardColor,
                // color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(workExperience),
                ),
              ),
              const SizedBox(height: 16),

              // Skills
              Card(
                color: Theme.of(context).cardColor,
                // color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(skills),
                ),
              ),
              const SizedBox(height: 16),

              // Achievements
              Card(
                color: Theme.of(context).cardColor,
                // color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(achievements),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
