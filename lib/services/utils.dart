import 'package:intl/intl.dart';

class Utils {
  static String dateFormatddMMMMyyyy(DateTime? date) {
    if (date != null) {
      final difference = DateTime.now().difference(date);
      if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else {
        return DateFormat('dd MMMM yyyy').format(date);
      }
    }
    return '';
  }

  static String timeFormat(DateTime? date) {
    if (date != null) {
      return DateFormat('HH:mm').format(date);
    }
    return '';
  }

  static DateTime? parseDate(String? date) {
    date = date ?? '';
    if (date.isEmpty || date == 'null') return null;

    // remove timezone e.g +07:00
    var splitDate = date.split('+');
    if (splitDate.isNotEmpty) date = splitDate.first;

    return DateTime.tryParse(date);
  }
}
