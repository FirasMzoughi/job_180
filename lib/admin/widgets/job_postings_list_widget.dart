// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'details_dialog.dart'; // Import the details dialog
import 'delete_dialog.dart'; // Import the delete dialog

Widget buildJobPostingsList({
  required List<Map<String, String>> jobs,
  required String searchQuery,
  required String sortBy,
  required bool isAscending,
  required BuildContext context,
}) {
  var filteredJobs = jobs
      .where((job) => job['title']!.toLowerCase().contains(searchQuery))
      .toList();
  if (sortBy == 'name') {
    filteredJobs.sort((a, b) => isAscending
        ? a['title']!.compareTo(b['title']!)
        : b['title']!.compareTo(a['title']!));
  } else {
    filteredJobs.sort((a, b) => isAscending
        ? a['status']!.compareTo(b['status']!)
        : b['status']!.compareTo(a['status']!));
  }

  return SizedBox(
    height: 220,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: filteredJobs.length,
      itemBuilder: (context, index) {
        final job = filteredJobs[index];
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
                      backgroundColor: const Color(0xFF42A5F5).withOpacity(0.2),
                      child: const Icon(Icons.work, color: Color(0xFF1976D2)),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job['title']!,
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
                  'By: ${job['startup']}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  job['location']!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Status: ${job['status']}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: job['status'] == 'Open' ? Colors.green : Colors.red,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.visibility, color: Color(0xFF1976D2)),
                      onPressed: () {
                        showDetailsDialog(context, 'Job: ${job['title']}');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDeleteDialog(context, 'job', job['title']!);
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