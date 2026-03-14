extension DatetimeExtension on DateTime {
  String get toReadable {
    return '$day/$month/$year';
  }

  bool get isToday {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }
}

void main() {
  final orderDate = DateTime(2026, 1, 11);
  print(orderDate.toReadable);
  print(orderDate.isToday);
}
