import 'package:flutter/widgets.dart';
import 'package:health_diary_watches_app/services/haptic_feedback_service.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<HapticFeedbackService>(
            create: (_) => HapticFeedbackService(),
          ),
        ],
        child: child,
      );
}
