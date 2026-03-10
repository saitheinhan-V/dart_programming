// void main() {
//   String userName = "Aung Aung";
//   int age = 20;
//   double height = 5.5;
//   bool single = false;
//   List<String> hobbies = ["football", "basketball"];

//   print("$userName is $age years old, $height inches tall, and ${single ? 'single' : 'married'}.");
//   print("He has ${hobbies.join(', ')} hobbies");
// }

import 'dart:io';

void main() {
  stdout.write("Enter distance: ");
  String? input = stdin.readLineSync();

  int distance = int.tryParse(input ?? '') ?? 0;

  print("Distance: $distance");
}
