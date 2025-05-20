import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job360/candidate/home.dart';
import 'package:job360/entreprise/widgets/category_card.dart';

class AllSkillCategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.code, 'title': 'Developers'},
    {'icon': Icons.design_services, 'title': 'Designers'},
    {'icon': Icons.people, 'title': 'Marketers'},
    {'icon': Icons.analytics, 'title': 'Analysts'},
    {'icon': Icons.account_balance, 'title': 'Finance'},
    {'icon': Icons.support_agent, 'title': 'Customer Support'},
    {'icon': Icons.build, 'title': 'Engineers'},
    {'icon': Icons.medical_services, 'title': 'Healthcare'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "All Skill Categories",
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
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(
                icon: categories[index]['icon'],
                title: categories[index]['title'],
              );
            },
          ),
        ),
      ),
    );
  }
}
