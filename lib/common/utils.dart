import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  final dateFormat = DateFormat('dd/MM, HH:mm');
  return dateFormat.format(dateTime);
}

enum SupportedLocale { en, ar }

extension SupportedLocalExtension on SupportedLocale {
  String get code => this.toString().split('.').last;
  String get name {
    String name;
    switch (this) {
      case SupportedLocale.en:
        name = 'English';
        break;
      case SupportedLocale.ar:
        name = 'العربية';
        break;
    }
    return name;
  }
}
