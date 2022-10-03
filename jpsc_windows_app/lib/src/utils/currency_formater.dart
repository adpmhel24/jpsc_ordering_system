import 'package:intl/intl.dart';

String formatStringToDecimal(var amount,
    {bool hasCurrency = false, int decimalPlaces = 2}) {
  String currency = 'Php ';
  var newValue = '';
  final f = NumberFormat.currency(
      locale: 'en_US', decimalDigits: decimalPlaces, symbol: '');
  var num = double.parse(amount.replaceAll(',', ''));
  if (hasCurrency) {
    newValue = currency + f.format(num).trim();
  } else {
    newValue = f.format(num).trim();
  }

  return newValue;
}
