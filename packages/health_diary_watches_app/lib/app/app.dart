import 'package:flutter/material.dart';
import 'package:health_diary_watches_app/modules/debug/screens/settings/debug_settings_screen.dart';
import 'package:health_diary_watches_app/services/theme_service.dart';

class App extends StatelessWidget {
  final ThemeService themeService;

  const App({required this.themeService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeService.lightTheme,
      darkTheme: themeService.dartTheme,
      home: const DebugSettingsScreen(),
    );
  }
}
