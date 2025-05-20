import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCandidatesScreen extends StatelessWidget {
  const SearchCandidatesScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Candidates"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search by skills, role, or location...",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
    );
  }
}