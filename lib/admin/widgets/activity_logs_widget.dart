// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

Widget buildActivityLogs(List<Map<String, String>> activityLogs, String searchQuery) {
  var filteredLogs = activityLogs
      .where((log) => log['details']!.toLowerCase().contains(searchQuery.toLowerCase()))
      .toList();

  return SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: filteredLogs.length,
      itemBuilder: (context, index) {
        final log = filteredLogs[index];
        return FadeInUp(
          duration: const Duration(milliseconds: 600),
          child: ListTile(
            leading: Icon(
              log['action']!.contains('Startup')
                  ? Icons.business
                  : log['action']!.contains('Job')
                      ? Icons.work
                      : Icons.person,
              color: Color(0xFF1976D2),
            ),
            title: Text(
              log['action']!,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              '${log['details']} • ${log['timestamp']}',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
        );
      },
    ),
  );
}