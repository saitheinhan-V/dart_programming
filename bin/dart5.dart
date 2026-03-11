void main() {
  //Late > will be defined value by the time it is called
  //but no value assigned at declaration
  //value can be changed
  late String firstName;
  //value can't be changed
  late final String lastName;

  //null aware operator ??
  String? userName;
  String display = userName ?? 'Guest'; // If null, use 'Guest'

  //null aware assignment ??=
  int? score;
  score ??= 0; // Only assigns if score is null
  // score ??= 1; // nothing happen since the value has been assigned

  //null aware access ?.
  String? email;
  int? length = email?.length; // Returns null if email is null

  //null assertion !
  String? definitelyHasValue = 'Hello';
  String unwrapped = definitelyHasValue!; // I'm 100% sure it's not null

  //List of nullable string
  List<String?> names = ['Sai', null, "Han", null];

  //Nullable list of nullable string
  List<String?>? city;

  //Filter out nulls
  List<String> nonnullName = names.whereType<String>().toList();
  print("Non null names : $nonnullName\n");

  //Filter out null using where
  List<String> filtered = names
      .where((name) => name != null)
      .map((name) => name!)
      .toList();
  print("Filter null names using where : $filtered");

  // Null-aware spread operator
  List<String>? additionalItems = ['Extra1', 'Extra2'];
  List<String>? nullItems;

  List<String> combined = [
    'Required',
    ...?additionalItems, // Spreads if not null
    ...?nullItems, // Does nothing because null
  ];
  print('Combined list: $combined\n');

  //Map
  Map<String, String?> userProfile = {
    'name': 'Alice',
    'email': 'alice@example.com',
    'bio': null,
    'website': null,
  };

  print('Name: ${userProfile['name']}');
  print('Bio: ${userProfile['bio'] ?? 'No bio provided'}');

  // Safe map access
  String? bio = userProfile['bio'];
  int? bioLength = bio?.length;
  print('Bio length: $bioLength\n');

  String? status;
  // Modern switch expression with null handling
  String message = switch (status) {
    String value when value == 'active' => 'User is active',
    String value when value == 'inactive' => 'User is inactive',
    String value => 'Unknown status: $value',
    null => 'No status available',
  };
  print('Status message: $message\n');
}
