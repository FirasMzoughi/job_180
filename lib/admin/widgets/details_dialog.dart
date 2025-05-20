// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showDetailsDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      content: Text(
        'Detailed information about $title would be displayed here.',
        style: GoogleFonts.poppins(),
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