import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EditCandidateProfileScreen extends StatefulWidget {
  @override
  _EditCandidateProfileScreenState createState() => _EditCandidateProfileScreenState();
}

class _EditCandidateProfileScreenState extends State<EditCandidateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String fullName = 'Jacob Jones';
  String email = 'jacob.jones@example.com';
  String experience = '';
  String skills = '';
  String summary = '';
  String education = '';

  InputDecoration _buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500),
      prefixIcon: Icon(icon, color: Colors.blue.shade700),
      filled: true,
      fillColor: Colors.blue.shade50,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _animatedField(Widget child, int delay) {
    return FadeInDown(
      duration: Duration(milliseconds: 500),
      delay: Duration(milliseconds: delay),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: child,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade700],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(LucideIcons.user, size: 40, color: Colors.blue.shade700),
          ),
          SizedBox(height: 12),
          Text(
            fullName,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _animatedField(
                      TextFormField(
                        initialValue: fullName,
                        decoration: _buildInputDecoration('Full Name', LucideIcons.user),
                        onSaved: (value) => fullName = value ?? '',
                      ),
                      100,
                    ),
                    _animatedField(
                      TextFormField(
                        initialValue: email,
                        decoration: _buildInputDecoration('Email Address', LucideIcons.mail),
                        onSaved: (value) => email = value ?? '',
                      ),
                      200,
                    ),
                    _animatedField(
                      TextFormField(
                        initialValue: summary,
                        maxLines: 3,
                        decoration: _buildInputDecoration('Summary', LucideIcons.fileText),
                        onSaved: (value) => summary = value ?? '',
                      ),
                      300,
                    ),
                    _animatedField(
                      TextFormField(
                        initialValue: experience,
                        maxLines: 3,
                        decoration: _buildInputDecoration('Experience', LucideIcons.briefcase),
                        onSaved: (value) => experience = value ?? '',
                      ),
                      400,
                    ),
                    _animatedField(
                      TextFormField(
                        initialValue: education,
                        maxLines: 2,
                        decoration: _buildInputDecoration('Education', LucideIcons.graduationCap),
                        onSaved: (value) => education = value ?? '',
                      ),
                      500,
                    ),
                    _animatedField(
                      TextFormField(
                        initialValue: skills,
                        maxLines: 2,
                        decoration: _buildInputDecoration('Skills', LucideIcons.star),
                        onSaved: (value) => skills = value ?? '',
                      ),
                      600,
                    ),
                    SizedBox(height: 30),
                    FadeInUp(
                      duration: Duration(milliseconds: 700),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 3,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Profile updated successfully!')),
                            );
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(LucideIcons.save, color: Colors.white),
                        label: Text('Save Changes', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
