import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import './auth_controller.dart';

class JobPostingController {
  final formKey = GlobalKey<FormState>();
  final jobTitleController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final requiredSkillsController = TextEditingController();
  final locationController = TextEditingController();
  final experienceLevelController = TextEditingController();
  final salaryMinController = TextEditingController();
  final salaryMaxController = TextEditingController();
  final startupEmailController = TextEditingController();
  bool isFullTime = true;
  bool isLoading = false;

  // Use Get.find() to access the singleton AuthController instance
  final AuthController _authController = Get.find<AuthController>();

  void dispose() {
    jobTitleController.dispose();
    jobDescriptionController.dispose();
    requiredSkillsController.dispose();
    locationController.dispose();
    experienceLevelController.dispose();
    salaryMinController.dispose();
    salaryMaxController.dispose();
    startupEmailController.dispose();
  }

  String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  String? validateSkills(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter required skills';
    }
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter valid skills, not an email';
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a location';
    }
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid location, not an email';
    }
    return null;
  }

  String? validateExperience(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter experience level';
    }
    if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid experience level, not an email';
    }
    return null;
  }

  String? validateSalary(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a salary';
    }
    if (double.tryParse(value) == null) {
      return 'Enter a valid number';
    }
    return null;
  }

  String? validateSalaryMax(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a max salary';
    }
    if (double.tryParse(value) == null) {
      return 'Enter a valid number';
    }
    final min = double.tryParse(salaryMinController.text);
    final max = double.tryParse(value);
    if (min != null && max != null && max < min) {
      return 'Max must be greater than min';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  Future<void> submitForm(BuildContext context) async {
    // Check if the user is authenticated using the user getter
    final user = _authController.user;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User not authenticated. Please sign in.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      isLoading = true;
      if (context.mounted) {
        (context as StatefulElement).markNeedsBuild();
      }

      try {
        await FirebaseFirestore.instance.collection('job_postings').add({
          'jobTitle': jobTitleController.text.trim(),
          'jobDescription': jobDescriptionController.text.trim(),
          'requiredSkills': requiredSkillsController.text.trim(),
          'location': locationController.text.trim(),
          'experienceLevel': experienceLevelController.text.trim(),
          'isFullTime': isFullTime,
          'salaryMin': double.tryParse(salaryMinController.text.trim()) ?? 0.0,
          'salaryMax': double.tryParse(salaryMaxController.text.trim()) ?? 0.0,
          'startupEmail': startupEmailController.text.trim(),
          'userId': user.uid, // Use user.uid instead of getUserId()
          'createdAt': Timestamp.now(),
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Job posted successfully!'),
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              duration: Duration(seconds: 3),
            ),
          );
        }

        formKey.currentState!.reset();
        jobTitleController.clear();
        jobDescriptionController.clear();
        requiredSkillsController.clear();
        locationController.clear();
        experienceLevelController.clear();
        salaryMinController.clear();
        salaryMaxController.clear();
        startupEmailController.clear();
        isFullTime = true;
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to post job: ${e.toString()}'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } finally {
        isLoading = false;
        if (context.mounted) {
          (context as StatefulElement).markNeedsBuild();
        }
      }
    }
  }
}