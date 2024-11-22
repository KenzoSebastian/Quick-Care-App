import 'package:intl/intl.dart';

class Formatter {
  static String rupiah(int value) {
    if (value == 0) {
      return 'Rp 0';
    }
    final rupiahFormat = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
    return rupiahFormat.format(value);
  }
}
