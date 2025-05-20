import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateDetailsScreen extends StatelessWidget {
  final String name;
  final String role;
  final String skills;
  final String location;
  final String experience;
  // Additional fields for richer details
  final String email;
  final String education;
  final String recentProject;
  final String availability;
  final String bio;
  final String cvUrl;
  final String avatarUrl;

  const CandidateDetailsScreen({
    Key? key,
    required this.name,
    required this.role,
    required this.skills,
    required this.location,
    required this.experience,
    this.email = 'candidate@example.com',
    this.education = 'Not provided',
    this.recentProject = 'Not provided',
    this.availability = 'Available',
    this.bio = 'No bio provided',
    this.cvUrl = 'https://example.com/cv.pdf',
    this.avatarUrl = 'https://placehold.co/150x150',
  }) : super(key: key);

  Future<void>   _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Job Opportunity at Our Startup',
        'body':
            'Dear $name,\n\nWe are impressed with your profile and would like to discuss a $role position at our startup. Please let us know your availability for a call.\n\nBest regards,\n[Your Startup Name]',
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
    final skillsList = skills.split(', ').map((skill) => skill.trim()).toList();
    // Mock proficiency scores for chart (0-100)
    final skillProficiencies = skillsList.asMap().map((i, skill) => MapEntry(
          skill,
          60.0 + (i * 10) % 40, // Vary scores between 60-100
        ));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        elevation: 0,
        title: Text(
          name,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[700]!, Colors.blue[500]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
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
                FadeInUp(
                  duration: Duration(milliseconds: 800),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[50]!, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue[100]!, width: 1),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ZoomIn(
                                duration: Duration(milliseconds: 1000),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(avatarUrl),
                                  backgroundColor: Colors.blue[100],
                                  onBackgroundImageError: (exception, stackTrace) {
                                    print('Image load error: $exception');
                                  },
                                  child: Icon(Icons.person, color: Colors.blue[700], size: 40),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: GoogleFonts.poppins(
                                        color: Colors.blue[900],
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      role,
                                      style: GoogleFonts.poppins(
                                        color: Colors.blue[700],
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.email, size: 16, color: Colors.blue[600]),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            email,
                                            style: GoogleFonts.poppins(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: availability == 'Available'
                                      ? Colors.green[100]
                                      : Colors.blue[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  availability,
                                  style: GoogleFonts.poppins(
                                    color: availability == 'Available'
                                        ? Colors.green[800]
                                        : Colors.blue[800],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Divider(color: Colors.blue[100]),
                          SizedBox(height: 20),
                          _buildDetailRow(
                            context: context,
                            icon: Icons.location_on,
                            label: "Location",
                            value: location,
                          ),
                          SizedBox(height: 16),
                          _buildDetailRow(
                            context: context,
                            icon: Icons.work_history,
                            label: "Experience",
                            value: experience,
                          ),
                          SizedBox(height: 16),
                          _buildDetailRow(
                            context: context,
                            icon: Icons.school,
                            label: "Education",
                            value: education,
                          ),
                          SizedBox(height: 16),
                          _buildDetailRow(
                            context: context,
                            icon: Icons.build,
                            label: "Recent Project",
                            value: recentProject,
                          ),
                          SizedBox(height: 16),
                          _buildDetailRow(
                            context: context,
                            icon: Icons.description,
                            label: "CV",
                            value: cvUrl,
                            isUrl: true,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Bio",
                            style: GoogleFonts.poppins(
                              color: Colors.blue[900],
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            bio,
                            style: GoogleFonts.poppins(
                              color: Colors.grey[700],
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                FadeInUp(
                  duration: Duration(milliseconds: 800),
                  delay: Duration(milliseconds: 200),
                  child: Text(
                    "Skills Proficiency",
                    style: GoogleFonts.poppins(
                      color: Colors.blue[900],
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                FadeInUp(
                  duration: Duration(milliseconds: 800),
                  delay: Duration(milliseconds: 400),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[100]!.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            // tooltipBackgroundColor: Colors.blue[700]!.withOpacity(0.8),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '${skillsList[groupIndex]}\n${rod.toY.toInt()}%',
                                GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() < skillsList.length) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      skillsList[value.toInt()],
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.blue[900],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                                return Text('');
                              },
                              reservedSize: 40,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}%',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.blue[900],
                                  ),
                                );
                              },
                              reservedSize: 30,
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        barGroups: skillsList.asMap().entries.map((entry) {
                          final index = entry.key;
                          final skill = entry.value;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: skillProficiencies[skill] ?? 60.0,
                                color: Colors.blue[600],
                                width: 20,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                FadeInUp(
                  duration: Duration(milliseconds: 800),
                  delay: Duration(milliseconds: 600),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 6,
                        shadowColor: Colors.blue[200],
                      ),
                      onPressed: () => _sendEmail(context),
                      child: Text(
                        "Contact Now",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    bool isUrl = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue[600]),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.blue[900],
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              isUrl
                  ? InkWell(
                      onTap: () async {
                        final url = Uri.parse(value);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Unable to open CV'),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : Text(
                      value,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}