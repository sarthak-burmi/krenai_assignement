// lib/utils/text_styles.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heading = GoogleFonts.tenorSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle subheading = GoogleFonts.tenorSans(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle body = GoogleFonts.tenorSans(
    fontSize: 16,
    color: Colors.black,
  );
}
