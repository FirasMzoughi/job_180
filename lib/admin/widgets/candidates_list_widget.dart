// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:job360/admin/candidate_detail.dart'; // Adjusted import path
import 'delete_dialog.dart'; // Import the delete dialog

class CandidatesListWidget extends StatelessWidget {
  final List<Map<String, String>> candidates;
  final String searchQuery;
  final String sortBy;
  final bool isAscending;

  const CandidatesListWidget({
    required this.candidates,
    required this.searchQuery,
    required this.sortBy,
    required this.isAscending,
  });

  @override
  Widget build(BuildContext context) {
    var filteredCandidates = candidates
        .where((candidate) =>
            candidate['name']!.toLowerCase().contains(searchQuery) ||
            candidate['role']!.toLowerCase().contains(searchQuery))
        .toList();
    if (sortBy == 'name') {
      filteredCandidates.sort((a, b) => isAscending
          ? a['name']!.compareTo(b['name']!)
          : b['name']!.compareTo(a['name']!));
    }

    

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filteredCandidates.length,
        itemBuilder: (context, index) {
          final candidate = filteredCandidates[index];
          return ElasticIn(
            duration: const Duration(milliseconds: 800),
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xFF42A5F5).withAlpha(51),
                        child: const Icon(Icons.person, color: Color(0xFF1976D2)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          candidate['name']!,
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
                    candidate['role']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Skills: ${candidate['skills']}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    candidate['location']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.visibility, color: Color(0xFF1976D2)),
                        onPressed: () {
                          // Navigate to CandidateDetailsScreen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CandidateDetailsScreen(
                                name: candidate['name']!,
                                role: candidate['role']!,
                                skills: candidate['skills']!,
                                location: candidate['location']!,
                                experience: 'N/A', // Placeholder
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDeleteDialog(context, 'candidate', candidate['name']!);
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