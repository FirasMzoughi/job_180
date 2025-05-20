// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/admin/candidate_detail.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateCard extends StatefulWidget {
  final String name;
  final String role;
  final String skills;
  final String location;
  final String experience;
  final String email;
  final String education;
  final String recentProject;
  final String availability;
  final String avatarUrl;

  const CandidateCard({
    required this.name,
    required this.role,
    required this.skills,
    required this.location,
    required this.experience,
    required this.email,
    required this.education,
    required this.recentProject,
    required this.availability,
    required this.avatarUrl,
  });

  @override
  _CandidateCardState createState() => _CandidateCardState();
}

class _CandidateCardState extends State<CandidateCard> {
  bool _isTapped = false;

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: widget.email,
      queryParameters: {
        'subject': 'Job Opportunity at Our Startup',
        'body':
            'Dear ${widget.name},\n\nWe are impressed with your profile and would like to discuss a ${widget.role} position at our startup. Please let us know your availability for a call.\n\nBest regards,\n[Your Startup Name]',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to open email client'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final skillsList = widget.skills.split(', ').map((skill) => skill.trim()).toList();

    return SlideInRight(
      duration: const Duration(milliseconds: 800),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) => setState(() => _isTapped = false),
        onTapCancel: () => setState(() => _isTapped = false),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CandidateDetailsScreen(
                name: widget.name,
                role: widget.role,
                skills: widget.skills,
                location: widget.location,
                experience: widget.experience,
              ),
            ),
          );
        },
        child: Transform.scale(
          scale: _isTapped ? 0.97 : 1.0,
          child: Container(
            width: 320,
            margin: EdgeInsets.only(right: 20, bottom: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[50]!.withOpacity(0.8),
                  Colors.white.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[200]!.withOpacity(0.3),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.blue[100]!, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ZoomIn(
                      duration: const Duration(milliseconds: 1000),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.avatarUrl),
                        backgroundColor: Colors.blue[100],
                        onBackgroundImageError: (exception, stackTrace) {
                          print('Image load error: $exception');
                        },
                        child: Icon(Icons.person, color: Colors.blue[700], size: 30),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.role,
                            style: GoogleFonts.poppins(
                              color: Colors.blue[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.availability == 'Available'
                            ? Colors.green[100]
                            : Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.availability,
                        style: GoogleFonts.poppins(
                          color: widget.availability == 'Available'
                              ? Colors.green[800]
                              : Colors.blue[800],
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.blue[600]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.location,
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.work_history, size: 16, color: Colors.blue[600]),
                    SizedBox(width: 8),
                    Text(
                      widget.experience,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.email, size: 16, color: Colors.blue[600]),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.email,
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  "Skills",
                  style: GoogleFonts.poppins(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skillsList.map((skill) {
                    return Chip(
                      label: Text(
                        skill,
                        style: GoogleFonts.poppins(
                          color: Colors.blue[800],
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: Colors.blue[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.blue[200]!),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text(
                  "Education",
                  style: GoogleFonts.poppins(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.education,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Recent Project",
                  style: GoogleFonts.poppins(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.recentProject,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 24),
                ZoomIn(
                  duration: const Duration(milliseconds: 800),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 6,
                      shadowColor: Colors.blue[200],
                    ),
                    onPressed: _sendEmail,
                    child: Center(
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