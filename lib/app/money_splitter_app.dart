import 'package:flutter/material.dart';

import '../data/app_database.dart';
import '../data/profile_repository.dart';
import '../features/editor/editor_screen.dart';

class MoneySplitterApp extends StatefulWidget {
  const MoneySplitterApp({super.key});

  @override
  State<MoneySplitterApp> createState() => _MoneySplitterAppState();
}

class _MoneySplitterAppState extends State<MoneySplitterApp> {
  late final AppDatabase _database;
  late final ProfileRepository _repository;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _database = AppDatabase();
    _repository = ProfileRepository(_database);
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Splitter',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: _themeMode,
      home: EditorScreen(
        repository: _repository,
        themeMode: _themeMode,
        onThemeModeChanged: (mode) {
          if (_themeMode != mode) setState(() => _themeMode = mode);
        },
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7C3AED),
      brightness: brightness,
      surface: isDark ? const Color(0xFF313338) : const Color(0xFFF7F7FA),
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF1E1F22)
          : const Color(0xFFF0F0F4),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark
            ? const Color(0xFF2B2D31)
            : const Color(0xFFF0F0F4),
        foregroundColor: scheme.onSurface,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF383A40) : Colors.white,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
      dividerColor: isDark ? const Color(0xFF4E5058) : const Color(0xFFD6D6DE),
      useMaterial3: true,
    );
  }
}
