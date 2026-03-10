import 'dart:io';

void main() {
  greet();
  // maritalStatus("Sai", "Han", false);

  // stdout.write("Enter number one : ");
  // int one = int.parse(stdin.readLineSync() ?? '0');
  // stdout.write("Enter number two : ");
  // int two = int.parse(stdin.readLineSync() ?? '0');

  // print("Sum is ${sum(one, two)}");
  // print("Multiplication is ${multiply(one, two)}");

  stdout.write("Enter city name : Yangon (or) Mandalay : \n");
  final name = stdin.readLineSync() ?? "";
  final result = findLocation(name);
  print(
    "Location of $name is at Latitude : ${result.lat} & Longitude : ${result.long}",
  );
}

void greet() {
  print("Hello, Good Morning!");
}

int sum(int one, int two) {
  return one + two;
}

int multiply(int one, int two) => one * two;

void maritalStatus(String firstName, [String? lastName, bool single = true]) {
  print(
    "${lastName != null ? "$firstName $lastName" : firstName} is ${single ? 'single' : 'married'}",
  );
}

({double lat, double long}) findLocation(String name) {
  if (name == "Yangon") {
    return (lat: 1.5, long: 5.5);
  } else if (name == "Mandalay") {
    return (lat: 6.6, long: 5.5);
  } else {
    return (lat: 0.0, long: 0.0);
  }
}
