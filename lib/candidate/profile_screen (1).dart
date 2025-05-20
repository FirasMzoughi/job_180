import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/candidate/edit_employer_profile_screen.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'edit_employer_profile_screen.dart'; // Remplacez par le bon chemin

class CandidateProfileScreen extends StatelessWidget {
  const CandidateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFFBBDEFB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Candidate Profile',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ZoomIn(
                  duration: const Duration(milliseconds: 600),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'avatar',
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Jacob Jones",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "jacob.jones@example.com",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                FadeInUp(
                  child: infoCard(),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => EditCandidateProfileScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      elevation: 3,
                    ),
                    icon: Icon(Icons.edit, color: Colors.blue[700]),
                    label: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add logout logic here
                      // For example: AuthService().signOut();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      elevation: 3,
                    ),
                    icon: Icon(Icons.logout, color: Colors.red[700]),
                    label: Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.red[700],
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

  Widget infoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionWithIcon("Summary", LucideIcons.fileText),
          sectionText("UI/UX designer with over 5 years of experience specializing in user-centered digital products."),
          const SizedBox(height: 16),
          sectionWithIcon("Experience", LucideIcons.briefcase),
          sectionRow("Senior UI/UX Designer", "Jun 2019 – Present", "ABC Company, New York"),
          sectionRow("UI/UX Designer", "Jan 2016 – May 2019", "XYZ Inc., New York"),
          const SizedBox(height: 16),
          sectionWithIcon("Education", LucideIcons.graduationCap),
          sectionRow("Bachelor of Design", "2011 – 2015", "University of California"),
          const SizedBox(height: 16),
          sectionWithIcon("Skills", LucideIcons.star),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              skillChip("Wireframing"),
              skillChip("Prototyping"),
              skillChip("User Research"),
              skillChip("Interaction Design"),
            ],
          )
        ],
      ),
    );
  }

  Widget sectionWithIcon(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue[700], size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget sectionText(String text) => Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          text,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
        ),
      );

  Widget sectionRow(String title, String duration, String place) => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              "$duration  •  $place",
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
      );

  Widget skillChip(String label) => Chip(
        label: Text(label),
        labelStyle: GoogleFonts.poppins(fontSize: 13),
        backgroundColor: const Color(0xFFE3F2FD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      );
}