void main() {
  final rawPrices = [100.0, 550.0, 200.0, 45.0, 700.0, 300.0];

  // ✓ EXISTENCE CHECKER: Is there ANY affordable item?
  final hasAffordable = rawPrices.any((price) => price <= 500);
  print('Has affordable items? $hasAffordable'); // true

  // ✓ UNIVERSAL CHECKER: Are ALL items expensive?
  final allExpensive = rawPrices.every((price) => price > 100);
  print('All items expensive? $allExpensive'); // false (45.0 is not)

  // Only proceed if we have affordable items
  if (!hasAffordable) {
    print('Sorry, no affordable items available!');
    return;
  }

  // Step 1: FILTER - Keep only affordable items
  final affordableItems = rawPrices.where((price) => price <= 500);
  print('After filtering: $affordableItems');
  // Result: [100.0, 200.0, 45.0, 300.0]

  // Step 2: TRANSFORMER - Apply 10% discount
  final discountedPrices = affordableItems.map((price) => price * 0.9);
  print('After discount: $discountedPrices');
  // Result: [90.0, 180.0, 40.5, 270.0]

  // Step 3: AGGREGATOR - Calculate total
  final total = discountedPrices.fold(0.0, (prev, curr) => prev + curr);
  print('Final Total: \$${total.toStringAsFixed(1)}');
  // Result: $580.50

  // ✓ EXISTENCE CHECK before processing
  if (!rawPrices.any((price) => price <= 500)) {
    print('Sorry, no affordable items available!');
    return;
  }

  // ✓ Now do the full chain
  final final_total = rawPrices
      .where((price) => price <= 500) // FILTER
      .map((price) => price * 0.9) // TRANSFORMER
      .fold(0.0, (sum, p) => sum + p); // AGGREGATOR

  print('Total: \$${final_total.toStringAsFixed(2)}');
}
