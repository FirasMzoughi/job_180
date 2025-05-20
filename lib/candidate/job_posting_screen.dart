import 'package:flutter/material.dart';

class JobPostingScreen extends StatefulWidget {
  const JobPostingScreen();

  @override
  _JobPostingScreenState createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _jobTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Job Posting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Job Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a job title";
                  }
                  return null;
                },
                onSaved: (value) {
                  _jobTitle = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("Job Posted: $_jobTitle");
                  }
                },
                child: Text("Post Job"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}