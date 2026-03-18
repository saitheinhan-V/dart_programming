//stream //stock price monitor
import 'dart:async';
import 'dart:math';

void main() async {
  print("📊 Stock Price Monitor Started\n");

  // Generate random stock prices every 500ms
  Stream<double> stockPrices = Stream.periodic(
    Duration(milliseconds: 500),
    (_) => 100 + Random().nextDouble() * 100, // $100-$200
  ).take(20);

  // Transform the stream with multiple operations
  final alertStream = stockPrices
      .map((price) => price.toStringAsFixed(2)) // Format to 2 decimals
      .map((priceStr) => double.parse(priceStr)) // Parse back
      .where((price) => price > 150.0) // Only prices above $150
      .map((price) => StockAlert(price: price, timestamp: DateTime.now()));

  // Listen to alerts
  int alertCount = 0;
  final subscription = alertStream.listen(
    (alert) {
      alertCount++;
      print(
        "🟢 ALERT #$alertCount: \$${alert.price.toStringAsFixed(2)} at ${alert.timestamp.toString().substring(11, 19)}",
      );
    },
    onDone: () {
      print("\n📈 Market closed. Total alerts: $alertCount");
    },
  );

  // Wait for stream to complete
  await Future.delayed(Duration(seconds: 12));
  await subscription.cancel();
}

class StockAlert {
  final double price;
  final DateTime timestamp;

  StockAlert({required this.price, required this.timestamp});
}
