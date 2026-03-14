//extension
extension IntExtension on int {
  String get formatKyat => '$this Kyats';

  String get formatDollar => '\$$this Dollars';

  String get formatKyatsWithCommas {
    return '${_addCommas(this)} Kyats';
  }

  String _addCommas(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

void main() {
  int price = 1000000;
  print(price.formatKyat); // Output: 1000000 Kyats
  print(price.formatDollar); // Output: $1000000 Dollars
  print(price.formatKyatsWithCommas); // Output: {1,000,000 Kyats}
}
