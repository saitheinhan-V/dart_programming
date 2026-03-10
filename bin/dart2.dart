import 'dart:io';

enum TravelMode {
  flight,
  train,
  bus,
  car;

  double get multiplier {
    if (this == .flight) {
      return 1.5;
    } else if (this == .train) {
      return 1.2;
    } else if (this == .car) {
      return 1.0;
    } else if (this == .bus) {
      return 0.8;
    }
    return 0;
  }
}

const appVersion = '1.0.0';
const costPerKm = 2;

void main(List<String> args) {
  print('🌏 Travel Planner');

  final planStartAt = DateTime.now();

  print('App version: $appVersion');
  print('Planning start: $planStartAt');

  stdout.write("Distance (km): ");
  final distance = int.parse(stdin.readLineSync() ?? '0');

  stdout.write('Budget (\$): ');
  final budget = int.parse(stdin.readLineSync() ?? '0');

  stdout.write('Is this urgent? (y/n): ');
  final isUrgent = stdin.readLineSync()?.toLowerCase() == 'y';

  print('\n=======================');

  TravelMode travelMode;
  String reason;

  if (distance > 500) {
    travelMode = .flight;
    reason = 'Long distance!';
  } else if (isUrgent && budget >= 3000) {
    travelMode = .flight;
    reason = 'Urgent travel with enough budget!';
  } else if (distance > 200 && budget >= 1500) {
    travelMode = .train;
    reason = 'Not too far with enough budget';
  } else if (budget < 1000) {
    travelMode = .bus;
    reason = 'Budget friendly!';
  } else {
    travelMode = .car;
    reason = 'Personal transportation';
  }

  final urgencyMessage = isUrgent ? '🏃 Urgent' : '🚶 Chill';

  final features = ['Basic Travel Package', if (isUrgent) 'Earliest booking'];

  final baseCost = distance * costPerKm;
  final estimatedCost = baseCost * travelMode.multiplier;

  print('🔖 Travel Plan');
  print('=======================');
  print('Distance: $distance km');
  print('Budget: $budget \$');
  print('Urgency: $urgencyMessage');

  print('\nℹ️  Result:');
  print('=======================');
  print('Mode: ${travelMode.name}');
  print('Reason: $reason');
  print('Estimated Cost: $estimatedCost');
  print('Features: ${features.join(', ')}');
  print(estimatedCost > budget ? '💸 Over budget' : ' 🤑 Affortable');
}