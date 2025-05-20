import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/candidate/home.dart';
import 'package:job360/candidate/job_details_screen.dart';
class CategoryCard extends StatefulWidget {
  final IconData icon;
  final String title;

  const CategoryCard({required this.icon, required this.title});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
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
          // Placeholder: Navigate to category jobs
        },
        child: Transform.scale(
          scale: _isTapped ? 0.95 : 1.0,
          child: Container(
            width: 120,
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, color: Color(0xFF1976D2), size: 34),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
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

  const JobCard({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.type,
    required this.remote,
  });

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool _isSaved = false;
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
                // company: widget.company,
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
            width: 300,
            height: 900,
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.all(12),
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
                        // Placeholder: Save/unsave job
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