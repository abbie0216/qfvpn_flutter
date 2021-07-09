

import 'package:intl/intl.dart';

String dateTimeDisplay(String date, String toFormat) {
  var displayFormatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
  var serverFormatter = DateFormat(toFormat);
  var displayDate = displayFormatter.parse(date);
  var formatted = serverFormatter.format(displayDate);
  return formatted;
}

String feedbackDateTimeDisplay(String date) {
  var displayFormatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
  var serverFormatter = DateFormat('yyyy-MM-dd HH:mm');
  var displayDate = displayFormatter.parse(date);
  var formatted = serverFormatter.format(displayDate);
  return formatted;
}