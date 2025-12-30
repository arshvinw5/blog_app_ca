import 'package:ca_blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static OutlineInputBorder _border([Color color = AppPalette.borderColor]) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppPalette.backgroundColor,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppPalette.backgroundColor,
      side: BorderSide.none,
    ),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient2),
    ),
  );
}
