import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job360/entreprise/widgets/candidate_card.dart';

class AllRecommendedCandidatesScreen extends StatelessWidget {
  final List<Map<String, String>> candidates = [
    {
      'name': 'Alya Khattab',
      'role': 'Flutter Developer',
      'skills': 'Flutter, Dart, Firebase',
      'location': 'Tunis, Tunisia',
      'experience': '3+ Years',
    },
    {
      'name': 'Mohamed Ali',
      'role': 'UI/UX Designer',
      'skills': 'Figma, Adobe XD',
      'location': 'Remote',
      'experience': '4+ Years',
    },
    {
      'name': 'Sara Ben Ammar',
      'role': 'Digital Marketer',
      'skills': 'SEO, Content Marketing',
      'location': 'London, UK',
      'experience': '2+ Years',
    },
    {
      'name': 'Ahmed Zied',
      'role': 'Data Analyst',
      'skills': 'Python, SQL, Tableau',
      'location': 'Dubai, UAE',
      'experience': '5+ Years',
    },
    {
      'name': 'Fatima Zahra',
      'role': 'Backend Developer',
      'skills': 'Node.js, MongoDB',
      'location': 'Casablanca, Morocco',
      'experience': '3+ Years',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Recommended Candidates",
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF1976D2)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.builder(
            itemCount: candidates.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: CandidateCard(
                  name: candidates[index]['name']!,
                  role: candidates[index]['role']!,
                  skills: candidates[index]['skills']!,
                  location: candidates[index]['location']!,
                  experience: candidates[index]['experience']!,
                  education: "bachelor",
                  recentProject: "new",
                  availability: "aa",
                  avatarUrl: "no",
                  email: "aa",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}