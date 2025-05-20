
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:job360/admin/candidate_detail.dart';
import 'package:job360/admin/widgets/details_dialog.dart';
import 'package:job360/entreprise/home.dart'; // For charts
import 'package:job360/admin/widgets/settings_dialog.dart';
import 'package:job360/admin/widgets/logout_dialog.dart';
import 'package:job360/admin/widgets/delete_dialog.dart';
import 'package:job360/admin/widgets/activity_logs_widget.dart';
import 'package:job360/admin/widgets/job_postings_list_widget.dart';
import 'package:job360/admin/widgets/candidates_list_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _sortBy = 'name'; // Default sort option
  bool _isAscending = true;

  // Sample data (replace with backend data)
  final List<Map<String, String>> startups = [
    {'name': 'TechTrend Innovations', 'industry': 'Technology', 'location': 'Tunis, Tunisia', 'status': 'Active'},
    {'name': 'GrowEasy Solutions', 'industry': 'Finance', 'location': 'London, UK', 'status': 'Pending'},
    {'name': 'NextGen AI', 'industry': 'AI', 'location': 'Remote', 'status': 'Active'},
  ];

  final List<Map<String, String>> candidates = [
    {'name': 'Alya Khattab', 'role': 'Flutter Developer', 'skills': 'Flutter, Dart', 'location': 'Tunis, Tunisia'},
    {'name': 'Mohamed Ali', 'role': 'UI/UX Designer', 'skills': 'Figma, Adobe XD', 'location': 'Remote'},
    {'name': 'Sara Ben Ammar', 'role': 'Digital Marketer', 'skills': 'SEO, Marketing', 'location': 'London, UK'},
  ];

  final List<Map<String, String>> jobs = [
    {'title': 'Flutter Developer', 'startup': 'TechTrend', 'location': 'Tunis, Tunisia', 'status': 'Open'},
    {'title': 'UI/UX Designer', 'startup': 'GrowEasy', 'location': 'Remote', 'status': 'Open'},
    {'title': 'Marketing Lead', 'startup': 'NextGen', 'location': 'London, UK', 'status': 'Closed'},
  ];

  final List<Map<String, String>> activityLogs = [
    {'action': 'Startup Approved', 'details': 'TechTrend Innovations', 'timestamp': '2025-05-12 10:30'},
    {'action': 'Job Posted', 'details': 'Flutter Developer', 'timestamp': '2025-05-11 15:45'},
    {'action': 'Candidate Added', 'details': 'Alya Khattab', 'timestamp': '2025-05-10 09:20'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Text(
          "Admin Control Center",
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Color(0xFF1976D2)),
            onPressed: () {
              // Placeholder: Navigate to admin settings
              showSettingsDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFF1976D2)),
            onPressed: () {
              showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    "Admin Dashboard",
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    "Oversee and manage all platform activities with ease.",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Search and Filters
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search startups, candidates, jobs...',
                              hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                              prefixIcon: Icon(Icons.search, color: Color(0xFF1976D2)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value.toLowerCase();
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.sort, color: Color(0xFF1976D2)),
                        onSelected: (value) {
                          setState(() {
                            if (value == _sortBy) {
                              _isAscending = !_isAscending;
                            } else {
                              _sortBy = value;
                              _isAscending = true;
                            }
                          });
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 'name', child: Text('Sort by Name', style: GoogleFonts.poppins())),
                          PopupMenuItem(value: 'status', child: Text('Sort by Status', style: GoogleFonts.poppins())),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Overview Statistics
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  child: Text(
                    "Platform Overview",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard(
                      title: "Startups",
                      count: "24",
                      icon: Icons.business,
                      color: Color(0xFF1976D2),
                    ),
                    _buildStatCard(
                      title: "Candidates",
                      count: "156",
                      icon: Icons.person,
                      color: Color(0xFF42A5F5),
                    ),
                    _buildStatCard(
                      title: "Jobs",
                      count: "89",
                      icon: Icons.work,
                      color: Color(0xFF0288D1),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Activity Chart
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 400),
                  child: Container(
                    height: 200,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
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
                        Text(
                          "Activity Trends",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        buildActivityLogs(activityLogs, _searchQuery),
                        Expanded(
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: false),
                              titlesData: FlTitlesData(show: false),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, 3),
                                    FlSpot(1, 4),
                                    FlSpot(2, 3.5),
                                    FlSpot(3, 5),
                                    FlSpot(4, 4.5),
                                  ],
                                  isCurved: true,
                                  color: Color(0xFF1976D2),
                                  barWidth: 4,
                                  dotData: FlDotData(show: false),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Startups Section
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Startups",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.download, color: Color(0xFF1976D2)),
                            onPressed: () {
                              // Placeholder: Export startups data
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Exporting startups data...')),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              // Placeholder: Navigate to full startups list
                            },
                            child: Text(
                              "View All",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _buildStartupsList(),

                // Candidates Section
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Candidates",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.download, color: Color(0xFF1976D2)),
                            onPressed: () {
                              // Placeholder: Export candidates data
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Exporting candidates data...')),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              // Placeholder: Navigate to full candidates list
                            },
                            child: Text(
                              "View All",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                CandidatesListWidget(
                  candidates: candidates,
                  searchQuery: _searchQuery,
                  sortBy: _sortBy,
                  isAscending: _isAscending,
                ),

                // Job Postings Section
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 1000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Job Postings",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.download, color: Color(0xFF1976D2)),
                            onPressed: () {
                              // Placeholder: Export jobs data
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Exporting jobs data...')),
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              // Placeholder: Navigate to full jobs list
                            },
                            child: Text(
                              "View All",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                buildJobPostingsList(
                jobs: jobs,
                searchQuery: _searchQuery,
                sortBy: _sortBy,
                isAscending: _isAscending,
                context: context,
              ),

                // Activity Logs Section
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 1200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Activity Logs",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Placeholder: Navigate to full logs
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.poppins(
                            color: Color(0xFF1976D2),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return ZoomIn(
      duration: const Duration(milliseconds: 800),
      child: Container(
        width: 110,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
          children: [
            Icon(icon, color: color, size: 34),
            const SizedBox(height: 10),
            Text(
              count,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartupsList() {
    var filteredStartups = startups
        .where((startup) => startup['name']!.toLowerCase().contains(_searchQuery))
        .toList();
    if (_sortBy == 'name') {
      filteredStartups.sort((a, b) => _isAscending
          ? a['name']!.compareTo(b['name']!)
          : b['name']!.compareTo(a['name']!));
    } else {
      filteredStartups.sort((a, b) => _isAscending
          ? a['status']!.compareTo(b['status']!)
          : b['status']!.compareTo(a['status']!));
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredStartups.length,
        itemBuilder: (context, index) {
          final startup = filteredStartups[index];
          return ElasticIn(
            duration: const Duration(milliseconds: 800),
            child: Container(
              width: 280,
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
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
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF42A5F5).withOpacity(0.2),
                        child: Icon(Icons.business, color: Color(0xFF1976D2)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          startup['name']!,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    startup['industry']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    startup['location']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Status: ${startup['status']}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: startup['status'] == 'Active' ? Colors.green : Colors.blue,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.visibility, color: Color(0xFF1976D2)),
                        onPressed: () {
                          // Placeholder: Navigate to startup details
                          showDetailsDialog(context, 'Startup: ${startup['name']}');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDeleteDialog(context, 'startup', startup['name']!);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

 

}