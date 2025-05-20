// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/candidate/search_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen();

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  // Sample saved jobs (in a real app, use state management or backend)
  final List<Map<String, String>> _savedJobs = [
    {
      "title": "Senior Recruiter",
      "company": "TechCorp",
      "location": "Tunis, Tunisia",
      "salary": "\$80K/Yr",
      "type": "Full Time",
      "remote": "Hybrid",
    },
    {
      "title": "HR Manager",
      "company": "GlobalHire",
      "location": "Remote",
      "salary": "\$90K/Yr",
      "type": "Full Time",
      "remote": "Remote",
    },
  ];

  void _removeJob(int index) {
    setState(() {
      _savedJobs.removeAt(index);
    });
  }

  void _clearAllJobs() {
    setState(() {
      _savedJobs.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[50]!,
            Colors.grey[100]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                BounceInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Saved Jobs",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      if (_savedJobs.isNotEmpty)
                        TextButton(
                          onPressed: _clearAllJobs,
                          child: Text(
                            "Clear All",
                            style: GoogleFonts.poppins(
                              color: Color(0xFF1976D2),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Saved Jobs or Empty State
                Expanded(
                  child: _savedJobs.isEmpty
                      ? FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 200),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark_border,
                                  size: 80,
                                  color: Color(0xFF1976D2).withOpacity(0.3),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "No saved jobs yet",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Explore and save jobs that interest you!",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                ZoomIn(
                                  duration: const Duration(milliseconds: 800),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF1976D2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 14,
                                        horizontal: 24,
                                      ),
                                      elevation: 6,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SearchScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Search Jobs",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _savedJobs.length,
                          itemBuilder: (context, index) {
                            final job = _savedJobs[index];
                            return FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: Duration(milliseconds: 200 * (index + 1)),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: JobCard(
                                  title: job["title"]!,
                                  company: job["company"]!,
                                  location: job["location"]!,
                                  salary: job["salary"]!,
                                  type: job["type"]!,
                                  remote: job["remote"]!,
                                  onUnsave: () => _removeJob(index),
                                ),
                              ),
                            );
                          },
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

class JobCard extends StatefulWidget {
  final String title;
  final String company;
  final String location;
  final String salary;
  final String type;
  final String remote;
  final VoidCallback? onUnsave;

  const JobCard({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.remote,
    this.onUnsave,
  });

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool _isSaved = true;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: const Duration(milliseconds: 800),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) => setState(() => _isTapped = false),
        onTapCancel: () => setState(() => _isTapped = false),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailsScreen(
                title: widget.title,
                company: widget.company,
                location: widget.location,
                salary: widget.salary,
                type: widget.type,
                remote: widget.remote,
              ),
            ),
          );
        },
        child: Transform.scale(
          scale: _isTapped ? 0.95 : 1.0,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xFF42A5F5).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF42A5F5).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.work_outline, color: Color(0xFF1976D2)),
                    ),
                    IconButton(
                      icon: Icon(
                        _isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Color(0xFF1976D2),
                      ),
                      onPressed: () {
                        setState(() {
                          _isSaved = !_isSaved;
                        });
                        if (!_isSaved && widget.onUnsave != null) {
                          widget.onUnsave!();
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.company,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.location,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      widget.type,
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.wifi, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      widget.remote,
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.monetization_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      widget.salary,
                      style: GoogleFonts.poppins(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ZoomIn(
                  duration: const Duration(milliseconds: 800),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1976D2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      elevation: 6,
                      shadowColor: Colors.black38,
                    ),
                    onPressed: () {
                      // Placeholder: Apply for job
                    },
                    child: Center(
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

class JobDetailsScreen extends StatelessWidget {
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