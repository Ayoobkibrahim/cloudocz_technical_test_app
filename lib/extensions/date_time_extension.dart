extension DateTimeExtension on DateTime {
 DateTime get toIst => toUtc().add(const Duration(hours: 5, minutes: 30));
}
