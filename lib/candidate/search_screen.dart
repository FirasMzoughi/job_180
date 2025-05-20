// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _recentSearches = [
    "Senior Recruiter",
    "HR Manager",
    "Remote Tech Jobs",
  ];
  final Map<String, bool> _filters = {
    "Full Time": false,
    "Part Time": false,
    "Remote": false,
    "Hybrid": false,
    "Tunis": false,
    "Remote Location": false,
  };

  void _onSearch(String query) {
    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) _recentSearches.removeLast();
      });
    }
    // Placeholder: Perform search
    print("Searching for: $query");
  }

  void _clearRecentSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  BounceInDown(
                    duration: const Duration(milliseconds: 800),
                    child: Text(
                      "Search Jobs",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF1976D2).withOpacity(0.2),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search jobs by title, company, or location...',
                                hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                                prefixIcon: Icon(Icons.search, color: Color(0xFF1976D2)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              ),
                              onSubmitted: _onSearch,
                            ),
                          ),
                          ZoomIn(
                            duration: const Duration(milliseconds: 1000),
                            child: IconButton(
                              icon: Icon(Icons.filter_list, color: Color(0xFF1976D2)),
                              onPressed: () {
                                // Placeholder: Show filter dialog
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Filters
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Filters",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _filters.updateAll((key, value) => false);
                                });
                              },
                              child: Text(
                                "Clear Filters",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFF1976D2),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _filters.keys.map((filter) {
                            return FilterChipWidget(
                              label: filter,
                              isSelected: _filters[filter]!,
                              onSelected: (selected) {
                                setState(() {
                                  _filters[filter] = selected;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Recent Searches
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Searches",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (_recentSearches.isNotEmpty)
                          TextButton(
                            onPressed: _clearRecentSearches,
                            child: Text(
                              "Clear",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF1976D2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 600),
                    child: _recentSearches.isEmpty
                        ? Center(
                            child: Text(
                              "No recent searches",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          )
                        : Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _recentSearches.map((search) {
                              return Chip(
                                label: Text(
                                  search,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                backgroundColor: Color(0xFF42A5F5).withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xFF1976D2), width: 1),
                                ),
                                onDeleted: () {
                                  setState(() {
                                    _recentSearches.remove(search);
                                  });
                                },
                              );
                            }).toList(),
                          ),
                  ),
                  const SizedBox(height: 20),

                  // Suggested Jobs
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 800),
                    child: Text(
                      "Suggested Jobs",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 1000),
                    child: Column(
                      children: [
                        JobCard(
                          title: "Senior Recruiter",
                          company: "TechCorp",
                          location: "Tunis, Tunisia",
                          salary: "\$80K/Yr",
                          type: "Full Time",
                          remote: "Hybrid",
                        ),
                        const SizedBox(height: 15),
                        JobCard(
                          title: "HR Manager",
                          company: "GlobalHire",
                          location: "Remote",
                          salary: "\$90K/Yr",
                          type: "Full Time",
                          remote: "Remote",
                        ),
                        const SizedBox(height: 15),
                        JobCard(
                          title: "Talent Acquisition Specialist",
                          company: "Innovate Inc.",
                          location: "London, UK",
                          salary: "\$75K/Yr",
                          type: "Part Time",
                          remote: "On-site",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const FilterChipWidget({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTapUp: (_) => setState(() => _isTapped = false),
      onTapCancel: () => setState(() => _isTapped = false),
      onTap: () {
        widget.onSelected(!widget.isSelected);
      },
      child: Transform.scale(
        scale: _isTapped ? 0.95 : 1.0,
        child: Chip(
          label: Text(
            widget.label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: widget.isSelected ? Colors.white : Colors.black87,
            ),
          ),
          backgroundColor: widget.isSelected ? Color(0xFF1976D2) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xFF1976D2), width: 1),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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