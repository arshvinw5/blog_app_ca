import 'package:intl/intl.dart';

String formatDateByMMMYYYY(DateTime datetime) {
  return DateFormat("d MMM, yyyy").format(datetime);
}
