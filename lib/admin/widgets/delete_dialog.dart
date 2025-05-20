// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showDeleteDialog(BuildContext context, String type, String name) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Delete $type',
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      content: Text(
        'Are you sure you want to delete $name?',
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
            // Placeholder: Implement delete logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$type $name deleted')),
            );
            Navigator.pop(context);
          },
          child: Text(
            'Delete',
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ),
      ],
    ),
  );
}