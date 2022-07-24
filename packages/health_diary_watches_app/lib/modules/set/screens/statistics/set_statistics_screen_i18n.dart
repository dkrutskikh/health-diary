import 'package:intl/intl.dart';

class SetStatisticsScreenI18n {
  static String get title => Intl.message(
        'Exercise set finished!',
        name: 'SetStatisticsScreenI18n_title',
        desc: 'Statistics screen title',
      );

  static String get buttonTitle => Intl.message(
        'OK',
        name: 'SetStatisticsScreenI18n_buttonTitle',
        desc: 'ok button',
      );
}
