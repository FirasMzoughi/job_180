// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Admin Settings',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'Manage Roles',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              // Placeholder: Navigate to role management
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigating to role management...')),
              );
            },
          ),
          ListTile(
            title: Text(
              'Platform Settings',
              style: GoogleFonts.poppins(),
            ),
            onTap: () {
              // Placeholder: Navigate to platform settings
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigating to platform settings...')),
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: GoogleFonts.poppins(color: Color(0xFF1976D2)),
          ),
        ),
      ],
    ),
  );
}