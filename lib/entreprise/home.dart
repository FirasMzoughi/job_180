import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job360/candidate/home.dart';
import 'package:job360/entreprise/application.dart';
import 'package:job360/entreprise/edit_startup_profile_screen.dart';
import 'package:job360/entreprise/job_startup_posting_screen.dart';
import 'package:job360/entreprise/notification.dart';
import 'package:job360/entreprise/profile.dart';
import 'package:job360/entreprise/candidat_details_screen.dart';
import 'package:job360/entreprise/search_candidates_screen.dart';
import 'package:job360/entreprise/widgets/AllRecommendedCandidatesScreen.dart';
import 'package:job360/entreprise/widgets/AllSkillCategoriesScreen.dart';
import 'package:job360/entreprise/widgets/candidate_card.dart';
import 'package:job360/entreprise/widgets/category_card.dart';

class StartupHomeScreen extends StatefulWidget {
  @override
  _StartupHomeScreenState createState() => _StartupHomeScreenState();
}

class _StartupHomeScreenState extends State<StartupHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const StartupHomeContent(),
    const SearchCandidatesScreen(),
    const JobPostingScreen(),
     ApplicantsScreen(),
    const StartupProfileScreen(),
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Color(0xFF1976D2),
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
            BottomNavigationBarItem(icon: Icon(Icons.work, size: 28), label: "Jobs"),
            BottomNavigationBarItem(icon: Icon(Icons.person_search, size: 28), label: "Applicants"),
            BottomNavigationBarItem(icon: Icon(Icons.business, size: 28), label: "Profile"),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}

class StartupHomeContent extends StatelessWidget {
  const StartupHomeContent();

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
                              backgroundImage: NetworkImage('https://placehold.co/150x150'),
                              backgroundColor: Color(0xFF42A5F5).withOpacity(0.2),
                              onBackgroundImageError: (exception, stackTrace) {
                                print('Image load error: $exception');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xFF1976D2), width: 2),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hi, StartupMzoughi",
                                style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Find Top Talent!",
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
                        icon: Icon(Icons.notifications, color: Color(0xFF1976D2), size: 28),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NotificationsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1976D2).withOpacity(0.15),
                          Color(0xFF42A5F5).withOpacity(0.15),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Complete your startup profile to attract top candidates!",
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
                              backgroundColor: Color(0xFF1976D2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              elevation: 4,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const EditStartupProfileScreen()),
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
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    "Discover\nTop Talent!",
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search candidates by skills, role, or location...',
                              hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                              prefixIcon: Icon(Icons.search, color: Color(0xFF1976D2)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            ),
                          ),
                        ),
                        ZoomIn(
                          duration: const Duration(milliseconds: 1000),
                          child: IconButton(
                            icon: Icon(Icons.filter_list, color: Color(0xFF1976D2)),
                            onPressed: () {
                              // Placeholder: Show filter options
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore Skill Categories",
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
                            MaterialPageRoute(builder: (context) => AllSkillCategoriesScreen()),
                          );
                        },
                        child: Text(
                          "See All",
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
                  delay: const Duration(milliseconds: 400),
                  child: SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CategoryCard(icon: Icons.code, title: "Developers"),
                        CategoryCard(icon: Icons.design_services, title: "Designers"),
                        CategoryCard(icon: Icons.people, title: "Marketers"),
                        CategoryCard(icon: Icons.analytics, title: "Analysts"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recommended Candidates",
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AllRecommendedCandidatesScreen()),
                          );
                        },
                        child: Text(
                          "See All",
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
                  delay: const Duration(milliseconds: 800),
                  child: SizedBox(
                    height: 360,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CandidateCard(
                          name: "Alya Khattab",
                          role: "Flutter Developer",
                          skills: "Flutter, Dart, Firebase",
                          location: "Tunis, Tunisia",
                          experience: "3+ Years",
                          email: "firas@gmail.com",
                          education: "bachelor",
                          recentProject: "new",
                          availability: "aa",
                          avatarUrl: "no",
                        ),
                        CandidateCard(
                          name: "Mohamed Ali",
                          role: "UI/UX Designer",
                          skills: "Figma, Adobe XD",
                          location: "Remote",
                          experience: "4+ Years",
                          email: "firas@gmail.com",
                           education: "bachelor",
                          recentProject: "new",
                          availability: "aa",
                          avatarUrl: "no",
                        ),
                        CandidateCard(
                          name: "Sara Ben Ammar",
                          role: "Digital Marketer",
                          skills: "SEO, Content Marketing",
                          location: "London, UK",
                          experience: "2+ Years",
                          email: "firas@gmail.com", education: "bachelor",
                          recentProject: "new",
                          availability: "aa",
                          avatarUrl: "no",
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


