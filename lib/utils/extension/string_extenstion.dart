import 'package:intl/intl.dart';

extension StringExtensions on String {
  String get convertRouteToName => replaceAll('/', '');

  String get formatDate {
    final dt = DateTime.parse(this);
    return DateFormat('dd-MMM-yyy').format(dt);
  }

  String get formatDateAndTime {
    final dt = DateTime.parse(this);
    return DateFormat('yy/MM/dd').add_jm().format(dt);
  }
}
