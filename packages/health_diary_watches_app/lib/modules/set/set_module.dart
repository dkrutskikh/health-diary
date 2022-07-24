import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/countdown/set_countdown_screen.dart';
import 'screens/start/set_start_screen.dart';
import 'screens/statistics/set_statistics_screen.dart';
import 'screens/workout/set_workout_screen.dart';

class SetModule extends StatelessWidget {
  final _router = GoRouter(
    routes: [
      GoRoute(
        name: 'start',
        path: '/',
        builder: (_, __) => const SetStartScreen(),
      ),
      GoRoute(
        name: 'countdown',
        path: '/countdown',
        builder: (_, __) => const SetCountdownScreen(),
      ),
      GoRoute(
        name: 'workout',
        path: '/workout',
        builder: (_, __) => const SetWorkoutScreen(),
      ),
      GoRoute(
        name: 'statistics',
        path: '/statistics',
        builder: (_, __) => const SetStatisticsScreen(),
      ),
    ],
    initialLocation: '/',
  );

  SetModule({super.key});

  @override
  Widget build(BuildContext context) => Router(
        restorationScopeId: 'set_module_router',
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      );
}
