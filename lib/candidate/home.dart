import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/candidate/profile_screen%20(1).dart';
import 'package:job360/candidate/saved_screen.dart' as saved;
import 'package:job360/candidate/search_screen.dart' as search;
import 'package:job360/entreprise/widgets/category_card.dart';
import 'package:job360/widget/edit_profile.dart';
import 'package:job360/widget/job-card.dart';

class HomeEmployerScreen extends StatefulWidget {
  const HomeEmployerScreen({super.key});

  @override
  _HomeEmployerScreenState createState() => _HomeEmployerScreenState();
}

class _HomeEmployerScreenState extends State<HomeEmployerScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeJobSeekerContent(),
    const search.SearchScreen(),
    const saved.SavedScreen(),
    const CandidateProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: const Color(0xFF1976D2),
          unselectedItemColor: Colors.grey[600],
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 28), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search, size: 28), label: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark, size: 28), label: "Saved"),
            BottomNavigationBarItem(icon: Icon(Icons.person, size: 28), label: "Profile"),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}

class HomeJobSeekerContent extends StatelessWidget {
  const HomeJobSeekerContent({super.key});

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
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                BounceInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ZoomIn(
                            duration: const Duration(milliseconds: 1000),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: const AssetImage('assets/placeholder.png'), // Use local asset
                              backgroundColor: const Color(0xFF42A5F5).withOpacity(0.2),
                              onBackgroundImageError: (exception, stackTrace) {
                                print('Image load error: $exception');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFF1976D2), width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi, Essya Ouni",
                                style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Find Your Dream Job!",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Color(0xFF1976D2), size: 28),
                        onPressed: () {
                          Navigator.pushNamed(context, '/notifications');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Profile Completion Banner
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1976D2).withOpacity(0.15),
                          const Color(0xFF42A5F5).withOpacity(0.15),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Complete your profile for better job matches!",
                            style: GoogleFonts.poppins(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ZoomIn(
                          duration: const Duration(milliseconds: 1000),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1976D2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                              );
                            },
                            child: Text(
                              "Update Now",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Greeting Section
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "Your Next\nCareer Awaits!",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
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
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search jobs by title, company, or location...',
                              hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                              prefixIcon: const Icon(Icons.search, color: Color(0xFF1976D2)),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            ),
                          ),
                        ),
                        ZoomIn(
                          duration: const Duration(milliseconds: 1000),
                          child: IconButton(
                            icon: const Icon(Icons.filter_list, color: Color(0xFF1976D2)),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Job Categories Section
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore Job Categories",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SeeAllScreen(type: 'categories'),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF1976D2),
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
                  delay: const Duration(milliseconds: 400),
                  child: SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CategoryCard(icon: Icons.work, title: "Recruitment"),
                        CategoryCard(icon: Icons.code, title: "Tech"),
                        CategoryCard(icon: Icons.people, title: "HR"),
                        CategoryCard(icon: Icons.business, title: "Management"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Recommended Jobs Section
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommended Jobs",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SeeAllScreen(type: 'jobs'),
                            ),
                          );
                        },
                        child: Text(
                          "See All",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF1976D2),
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
                  delay: const Duration(milliseconds: 800),
                  child: SizedBox(
                    height: 360,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        SizedBox(
                          width: 300,
                          child: JobCard(
                            title: "Senior Recruiter",
                            company: "TechCorp",
                            location: "Tunis, Tunisia",
                            salary: "\$80K/Yr",
                            type: "Full Time",
                            remote: "Hybrid",
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: JobCard(
                            title: "HR Manager",
                            company: "GlobalHire",
                            location: "Remote",
                            salary: "\$90K/Yr",
                            type: "Full Time",
                            remote: "Remote",
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: JobCard(
                            title: "Talent Acquisition Specialist",
                            company: "Innovate Inc.",
                            location: "London, UK",
                            salary: "\$75K/Yr",
                            type: "Part Time",
                            remote: "On-site",
                          ),
                        ),
                      ],
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

class SeeAllScreen extends StatelessWidget {
  final String type;

  const SeeAllScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1976D2)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          type == 'categories' ? 'All Job Categories' : 'All Recommended Jobs',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: type == 'categories' ? _buildCategoriesGrid() : _buildJobsList(),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    final categories = [
      {'icon': Icons.work, 'title': 'Recruitment'},
      {'icon': Icons.code, 'title': 'Tech'},
      {'icon': Icons.people, 'title': 'HR'},
      {'icon': Icons.business, 'title': 'Management'},
      {'icon': Icons.health_and_safety, 'title': 'Healthcare'},
      {'icon': Icons.engineering, 'title': 'Engineering'},
      {'icon': Icons.account_balance, 'title': 'Finance'},
      {'icon': Icons.school, 'title': 'Education'},
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: Duration(milliseconds: 100 * index),
          child: CategoryCard(
            icon: categories[index]['icon'] as IconData,
            title: categories[index]['title'] as String,
          ),
        );
      },
    );
  }

  Widget _buildJobsList() {
    final jobs = [
      {
        'title': 'Senior Recruiter',
        'company': 'TechCorp',
        'location': 'Tunis, Tunisia',
        'salary': '\$80K/Yr',
        'type': 'Full Time',
        'remote': 'Hybrid',
      },
      {
        'title': 'HR Manager',
        'company': 'GlobalHire',
        'location': 'Remote',
        'salary': '\$90K/Yr',
        'type': 'Full Time',
        'remote': 'Remote',
      },
      {
        'title': 'Talent Acquisition Specialist',
        'company': 'Innovate Inc.',
        'location': 'London, UK',
        'salary': '\$75K/Yr',
        'type': 'Part Time',
        'remote': 'On-site',
      },
      {
        'title': 'Software Engineer',
        'company': 'TechTrend',
        'location': 'San Francisco, USA',
        'salary': '\$120K/Yr',
        'type': 'Full Time',
        'remote': 'Hybrid',
      },
      {
        'title': 'Marketing Manager',
        'company': 'GrowEasy',
        'location': 'New York, USA',
        'salary': '\$85K/Yr',
        'type': 'Full Time',
        'remote': 'On-site',
      },
    ];

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: Duration(milliseconds: 100 * index),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: JobCard(
              title: jobs[index]['title'] as String,
              company: jobs[index]['company'] as String,
              location: jobs[index]['location'] as String,
              salary: jobs[index]['salary'] as String,
              type: jobs[index]['type'] as String,
              remote: jobs[index]['remote'] as String,
            ),
          ),
        );
      },
    );
  }
}