

import 'package:intl/intl.dart';

String dateTimeDisplay(String date) {
  var displayFormatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
  var serverFormatter = DateFormat('MM/dd HH:mm');
  var displayDate = displayFormatter.parse(date);
  var formatted = serverFormatter.format(displayDate);
  return formatted;
}