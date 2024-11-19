

import 'package:flutter/material.dart';

class AppTheme {
  
  final bool isDark;

  AppTheme({required this.isDark});

  ThemeData getTheme()=> ThemeData(
    useMaterial3: true,
    brightness: isDark ? Brightness.dark : Brightness.light,
    colorSchemeSeed: Colors.blue
  );

}