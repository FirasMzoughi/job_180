// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class CandidateDetailsScreen extends StatelessWidget {
  final String name;
  final String role;
  final String skills;
  final String location;
  final String experience;

  const CandidateDetailsScreen({
    required this.name,
    required this.role,
    required this.skills,
    required this.location,
    required this.experience,
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
          "Candidate Details",
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
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  role,
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
                            Icon(Icons.star, color: Color(0xFF1976D2), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              skills,
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.work_history, color: Color(0xFF1976D2), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              experience,
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
                    "About Candidate",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Experienced professional with a passion for innovation and teamwork. Skilled in delivering high-quality solutions.",
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
                        // Placeholder: Contact candidate
                      },
                      child: Text(
                        "Contact Now",
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