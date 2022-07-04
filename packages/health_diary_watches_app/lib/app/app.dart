import 'package:flutter/material.dart';
import 'package:health_diary_watches_app/modules/app/screens/debug_settings/debug_settings_screen.dart';
import 'package:health_diary_watches_app/services/theme_service.dart';

class App extends StatelessWidget {
  final ThemeService themeService;

  const App({super.key, required this.themeService});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: themeService.lightTheme,
        darkTheme: themeService.dartTheme,
        home: const DebugSettingsScreen(),
      );
}
