import 'package:intl/intl.dart';

String dateFormatter(DateTime dateTime) {
  final f = DateFormat('MM/dd/yyyy hh:mm a');
  return f.format(dateTime);
}
