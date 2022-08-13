import 'package:flutter/material.dart';
import 'package:health_diary_watches_app/services/theme_service.dart';

import '../modules/set/set_module.dart';

class App extends StatelessWidget {
  final ThemeService themeService;

  const App({super.key, required this.themeService});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: themeService.lightTheme,
        darkTheme: themeService.dartTheme,
        home: SetModule(),
      );
}
