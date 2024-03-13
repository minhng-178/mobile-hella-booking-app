import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get getStartDate {
    DateFormat transactionDateFormat = DateFormat('dd MMM yy');
    return transactionDateFormat.format(this);
  }

  String get getEndDate {
    DateFormat transactionDateFormat = DateFormat('dd MMM yy');
    return transactionDateFormat.format(this);
  }
}

String formatDateTime(String? date) {
  DateTime parsedDate;

  if (date != null) {
    parsedDate = DateFormat('dd MMM').parse(date);
    parsedDate =
        DateTime(DateTime.now().year, parsedDate.month, parsedDate.day);
  } else {
    parsedDate = DateTime.now();
  }

  return DateFormat('yyyy-MM-ddTHH:mm:ss.sssZ').format(parsedDate);
}

DateTime parseDate(String? dateString) {
  if (dateString == null) {
    return DateTime.now();
  }
  return DateTime.parse(dateString);
}

String formatDateString(String date) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
  DateFormat outputFormat = DateFormat("dd MMM yy", "en_US");

  DateTime dateTime = inputFormat.parse(date);
  String formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}
