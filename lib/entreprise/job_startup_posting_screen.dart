import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/controllers/job_posting_controller.dart';


class JobPostingScreen extends StatefulWidget {
  const JobPostingScreen({Key? key}) : super(key: key);

  @override
  _JobPostingScreenState createState() => _JobPostingScreenState();
}

class _JobPostingScreenState extends State<JobPostingScreen> {
  final JobPostingController _controller = JobPostingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: _buildFormCard(context),
                ),
                const SizedBox(height: 32),
                _buildSubmitButton(context),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Text(
            "Create a Job Posting",
            style: GoogleFonts.poppins(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          delay: const Duration(milliseconds: 100),
          child: Text(
            "Reach the best candidates with a detailed job listing",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(
                  controller: _controller.jobTitleController,
                  label: "Job Title",
                  hint: "e.g., Senior Flutter Developer",
                  validator: _controller.validateNotEmpty,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _controller.jobDescriptionController,
                  label: "Job Description",
                  hint: "Describe the role and responsibilities...",
                  maxLines: 5,
                  validator: _controller.validateNotEmpty,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _controller.requiredSkillsController,
                  label: "Required Skills",
                  hint: "e.g., Flutter, Dart, Firebase",
                  validator: _controller.validateNotEmpty,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _controller.locationController,
                  label: "Location",
                  hint: "e.g., Tunis, Tunisia or Remote",
                  validator: _controller.validateNotEmpty,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _controller.experienceLevelController,
                  label: "Experience Level",
                  hint: "e.g., 3+ Years",
                  validator: _controller.validateNotEmpty,
                ),
                const SizedBox(height: 20),
                _buildEmploymentType(),
                const SizedBox(height: 20),
                _buildSalaryFields(),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _controller.startupEmailController,
                  label: "Startup Email",
                  hint: "e.g., hiring@startup.com",
                  keyboardType: TextInputType.emailAddress,
                  validator: _controller.validateEmail,
                  onSubmitted: (_) => _controller.submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmploymentType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Employment Type",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                title: Text(
                  "Full-Time",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                value: true,
                groupValue: _controller.isFullTime,
                onChanged: (value) {
                  setState(() {
                    _controller.isFullTime = value!;
                  });
                },
                activeColor: Colors.blue[700],
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                title: Text(
                  "Part-Time",
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
                value: false,
                groupValue: _controller.isFullTime,
                onChanged: (value) {
                  setState(() {
                    _controller.isFullTime = value!;
                  });
                },
                activeColor: Colors.blue[700],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSalaryFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _controller.salaryMinController,
            label: "Salary Min",
            hint: "e.g., 50000",
            keyboardType: TextInputType.number,
            validator: _controller.validateSalary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTextField(
            controller: _controller.salaryMaxController,
            label: "Salary Max",
            hint: "e.g., 80000",
            keyboardType: TextInputType.number,
            validator: _controller.validateSalaryMax,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 200),
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            shadowColor: Colors.blue[200],
          ),
          onPressed: _controller.isLoading ? null : () => _controller.submitForm(context),
          child: _controller.isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              : Text(
                  "Post Job",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    void Function(String)? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue[900],
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[700]!, width: 2),
            ),
            filled: true,
            fillColor: Colors.blue[50],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIcon: label.contains("Salary")
                ? Icon(Icons.attach_money, color: Colors.blue[700])
                : label.contains("Email")
                    ? Icon(Icons.email_outlined, color: Colors.blue[700])
                    : null,
          ),
          validator: validator,
          onFieldSubmitted: onSubmitted,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
      ],
    );
  }
}