import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  static CurrencyTextInputFormatter formatter({
    int decimal = 0,
    String symbol = "N",
  }) {
    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      decimalDigits: 0,
      symbol: symbol,
    );
    return formatter;
  }

  static format({int decimal = 0, String symbol = "N", required String value}) {
    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      decimalDigits: decimal,
      symbol: symbol,
    );
    return formatter.format(value);
  }
}

class Dateformatter {
  static String formatyMMMd(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String formatEEyMMMd(DateTime date) {
    return DateFormat.yMMMEd().format(date);
  }

  static String formatYYYYMMMDD(DateTime date) {
    return DateFormat('y-MM-dd').format(date);
  }
}
