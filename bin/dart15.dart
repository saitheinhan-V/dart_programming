class User {
  final String firstName;
  final String lastName;
  final DateTime birthDate;

  User(this.firstName, this.lastName, this.birthDate);

  String get fullName => '$firstName $lastName';

  int get age {
    final today = DateTime.now();
    return today.year - birthDate.year;
  }

  bool get isAdult => age >= 18;
}

extension UserExtensions on User {
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  String greet() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning, $firstName!';
    return 'Good evening, $firstName!';
  }
}

void main() {
  final user = User('Aung', 'Aung', DateTime(2000, 1, 1));

  print('fullname: ${user.fullName}');
  print('age: ${user.age}');
  print('isAdult: ${user.isAdult}');
  print('initials: ${user.initials}');
  print(user.greet());
}
