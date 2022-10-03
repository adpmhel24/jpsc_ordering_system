import 'package:intl/intl.dart';

String dateFormatter(DateTime dateTime, [DateFormat? format]) {
  final f = format ?? DateFormat('MM/dd/yyyy hh:mm a');
  return f.format(dateTime);
}
