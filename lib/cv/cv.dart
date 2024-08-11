import 'package:flutter/material.dart';

class CVPage extends StatefulWidget {
  const CVPage({super.key});

  @override
  CVPageState createState() => CVPageState();
}

class CVPageState extends State<CVPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _workExperienceController =
      TextEditingController();
  final TextEditingController _skillsController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _educationController.dispose();
    _workExperienceController.dispose();
    _skillsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your CV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Personal Information Section
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 18),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // Education Section
              const Text(
                'Education',
                style: TextStyle(fontSize: 18),
              ),
              TextFormField(
                controller: _educationController,
                decoration: const InputDecoration(labelText: 'Education'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your educational background';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // Work Experience Section
              const Text(
                'Work Experience',
                style: TextStyle(fontSize: 18),
              ),
              TextFormField(
                controller: _workExperienceController,
                decoration: const InputDecoration(labelText: 'Work Experience'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your work experience';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              // Skills Section
              const Text(
                'Skills',
                style: TextStyle(fontSize: 18),
              ),
              TextFormField(
                controller: _skillsController,
                decoration: const InputDecoration(labelText: 'Skills'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your skills';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Process the data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
