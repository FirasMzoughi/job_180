import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';class JobDetailsScreen extends StatelessWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String remote;

  const JobDetailsScreen({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.remote,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF1976D2)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Job Details",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZoomIn(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  company,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF1976D2), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              location,
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.monetization_on, color: Color(0xFF1976D2), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              salary,
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Color(0xFF1976D2), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              type,
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.wifi, color: Color(0xFF1976D2), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              remote,
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    "Job Description",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Join our team to lead recruitment efforts, source top talent, and drive hiring strategies.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        elevation: 6,
                      ),
                      onPressed: () {
                        // Placeholder: Apply for job
                      },
                      child: Text(
                        "Apply Now",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder EditProfileScreen
