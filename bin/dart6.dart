void main() {
  processUserData(
    name: 'Alice',
    age: null,
    email: 'alice@example.com',
    hobbies: null,
  );

  print('');

  processUserData(
    name: 'Bob',
    age: 30,
    email: null,
    hobbies: ['reading', 'gaming'],
  );
}

String? getNameFromDatabase() {
  // Simulating database lookup
  return DateTime.now().second % 2 == 0 ? 'John Doe' : null;
}

void greetUser(String? name) {
  // Function accepting nullable parameter
  String greeting = 'Hello, ${name ?? 'Guest'}!';
  print(greeting);
}

String? findUserById(String id) {
  // Function returning nullable value
  Map<String, String> users = {'123': 'Alice', '456': 'Bob'};
  return users[id]; // Returns null if not found
}

Future<void> asyncNullSafetyDemo() async {
  print('Fetching user data...');

  String? username = await fetchUsername();

  if (username != null) {
    print('Welcome back, $username');
  } else {
    print('Welcome, Guest');
  }

  // Chaining with null-aware
  String display = username ?? 'Anonymous';
  print('Display name: $display');
}

Future<String?> fetchUsername() async {
  // Simulating API call
  await Future.delayed(Duration(milliseconds: 100));
  return DateTime.now().second % 2 == 0 ? 'AsyncUser' : null;
}

String? getStatus() {
  List<String?> statuses = ['active', 'inactive', null];
  return statuses[DateTime.now().second % 3];
}

void processUserData({
  required String name,
  int? age,
  String? email,
  List<String>? hobbies,
}) {
  print('Processing data for: $name');

  // Type promotion in action
  if (age != null) {
    print('  Age: $age');
    // age is promoted to int (non-nullable) here
    int yearsTo100 = 100 - age;
    print('  Years to 100: $yearsTo100');
  } else {
    print('  Age: Not provided');
  }

  // Null-aware access
  print('  Email: ${email ?? 'No email'}');

  // Null-aware spread in list
  List<String> info = [
    'Name: $name',
    if (age != null) 'Age: $age',
    ...?hobbies?.map((h) => 'Hobby: $h'),
  ];

  print('  Summary: ${info.join(', ')}');
}
