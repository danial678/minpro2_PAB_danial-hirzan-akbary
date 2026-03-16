import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';

class TurtleConservationApp extends StatefulWidget {
  const TurtleConservationApp({super.key});

  static _TurtleConservationAppState? of(BuildContext context) {
    return context.findAncestorStateOfType<_TurtleConservationAppState>();
  }

  @override
  State<TurtleConservationApp> createState() => _TurtleConservationAppState();
}

class _TurtleConservationAppState extends State<TurtleConservationApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turtle Conservation',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const LoginPage(),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF006994),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF0F8FF),
      textTheme: GoogleFonts.poppinsTextTheme(),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF2E8B57),
        foregroundColor: Colors.white,
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF006994),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0A1929),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF3CB371),
        foregroundColor: Colors.white,
      ),
    );
  }
}