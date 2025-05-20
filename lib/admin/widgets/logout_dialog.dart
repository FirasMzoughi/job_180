// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Logout',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      content: Text(
        'Are you sure you want to logout?',
        style: GoogleFonts.poppins(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(color: Colors.grey[600]),
          ),
        ),
        TextButton(
          onPressed: () {
            // Placeholder: Implement logout logic
            Navigator.pop(context);
          },
          child: Text(
            'Logout',
            style: GoogleFonts.poppins(color: Color(0xFF1976D2)),
          ),
        ),
      ],
    ),
  );
}