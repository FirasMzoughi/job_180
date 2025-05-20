// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/candidate/search_screen.dart';
import 'package:intl/intl.dart';

class NotificationsEmployerScreen extends StatefulWidget {
  const NotificationsEmployerScreen();

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsEmployerScreen> {
  // Sample notifications (in a real app, fetch from backend or push notifications)
  final List<Map<String, dynamic>> _notifications = [
    {
      "title": "Application Accepted",
      "message": "Congratulations! TechCorp has accepted your application for Senior Recruiter.",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
      "isRead": false,
      "status": "accepted",
      "job": {
        "title": "Senior Recruiter",
        "company": "TechCorp",
        "location": "Tunis, Tunisia",
        "salary": "\$80K/Yr",
        "type": "Full Time",
        "remote": "Hybrid",
      },
    },
    {
      "title": "Interview Scheduled",
      "message": "GlobalHire has scheduled an interview for HR Manager on May 12, 2025.",
      "timestamp": DateTime.now().subtract(Duration(days: 1)),
      "isRead": false,
      "status": "interview",
      "job": {
        "title": "HR Manager",
        "company": "GlobalHire",
        "location": "Remote",
        "salary": "\$90K/Yr",
        "type": "Full Time",
        "remote": "Remote",
      },
    },
    {
      "title": "Application Rejected",
      "message": "Unfortunately, Innovate Inc. has decided not to move forward with your application for Talent Acquisition Specialist.",
      "timestamp": DateTime.now().subtract(Duration(days: 3)),
      "isRead": true,
      "status": "rejected",
      "job": {
        "title": "Talent Acquisition Specialist",
        "company": "Innovate Inc.",
        "location": "London, UK",
        "salary": "\$75K/Yr",
        "type": "Part Time",
        "remote": "On-site",
      },
    },
    {
      "title": "New Job Match",
      "message": "A new job matching your skills has been posted: Junior HR Specialist at StartUpX.",
      "timestamp": DateTime.now().subtract(Duration(minutes: 30)),
      "isRead": false,
      "status": "match",
      "job": null,
    },
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index]["isRead"] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification["isRead"] = true;
      }
    });
  }

  void _clearAllNotifications() {
    setState(() {
      _notifications.clear();
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF1976D2)),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
          title: Text(
            "Notifications",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          actions: [
            if (_notifications.isNotEmpty)
              TextButton(
                onPressed: _markAllAsRead,
                child: Text(
                  "Mark All as Read",
                  style: GoogleFonts.poppins(
                    color: Color(0xFF1976D2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notifications or Empty State
                Expanded(
                  child: _notifications.isEmpty
                      ? FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          delay: const Duration(milliseconds: 200),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_none,
                                  size: 80,
                                  color: Color(0xFF1976D2).withOpacity(0.3),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "No notifications yet",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Apply for jobs to receive updates!",
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
                          itemCount: _notifications.length,
                          itemBuilder: (context, index) {
                            final notification = _notifications[index];
                            return FadeInUp(
                              duration: const Duration(milliseconds: 800),
                              delay: Duration(milliseconds: 200 * (index + 1)),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: NotificationCard(
                                  title: notification["title"],
                                  message: notification["message"],
                                  timestamp: notification["timestamp"],
                                  isRead: notification["isRead"],
                                  status: notification["status"],
                                  job: notification["job"],
                                  onTap: () => _markAsRead(index),
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

// The rest of the code (NotificationCard and JobDetailsScreen) remains unchanged

class NotificationCard extends StatefulWidget {
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String status;
  final Map<String, String>? job;
  final VoidCallback onTap;

  const NotificationCard({
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
    required this.status,
    this.job,
    required this.onTap,
  });

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool _isTapped = false;

  IconData _getStatusIcon() {
    switch (widget.status) {
      case "accepted":
        return Icons.check_circle;
      case "rejected":
        return Icons.cancel;
      case "interview":
        return Icons.event;
      case "match":
        return Icons.star;
      default:
        return Icons.info;
    }
  }

  Color _getStatusColor() {
    switch (widget.status) {
      case "accepted":
        return Colors.green;
      case "rejected":
        return Colors.red;
      case "interview":
        return Color(0xFF1976D2);
      case "match":
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      duration: const Duration(milliseconds: 800),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isTapped = true),
        onTapUp: (_) => setState(() => _isTapped = false),
        onTapCancel: () => setState(() => _isTapped = false),
        onTap: () {
          widget.onTap();
          if (widget.job != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobDetailsScreen(
                  title: widget.job!["title"]!,
                  company: widget.job!["company"]!,
                  location: widget.job!["location"]!,
                  salary: widget.job!["salary"]!,
                  type: widget.job!["type"]!,
                  remote: widget.job!["remote"]!,
                ),
              ),
            );
          }
        },
        child: Transform.scale(
          scale: _isTapped ? 0.95 : 1.0,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.isRead ? Colors.white : Color(0xFF42A5F5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: widget.isRead ? Colors.grey[200]! : Color(0xFF1976D2),
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getStatusIcon(),
                    color: _getStatusColor(),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.message,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMM d, yyyy • h:mm a').format(widget.timestamp),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
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