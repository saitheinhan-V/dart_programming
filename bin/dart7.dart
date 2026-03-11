void main() {
  List<String> fruits = ['apple', 'orange', 'banana'];
  print(fruits[0]);

  fruits.add('apple');
  print("$fruits");
  fruits.insert(0, 'guava');
  print("$fruits");

  print(fruits.first);
  print(fruits.last);

  fruits.remove('apple');
  print("$fruits");

  fruits.clear();

  //Set > for unique value
  Set<int> userIds = {10, 20, 10, 30};
  print(userIds); //10,20,30

  userIds.add(40);
  userIds.add(10); //ignored! already exist
  print(userIds);

  userIds.remove(10);
  print(userIds);

  print(userIds.contains(10)); //false

  userIds.clear();
  print(userIds);

  //List to Set
  List<int> userIdList = [10, 20, 30, 10, 40];

  var unique = userIdList.toSet();
  print(unique); //10,20,30,40

  //Map > key,value pair
  Map<String, dynamic> user = {
    'name': 'Sai Sai',
    'age': 20,
    'address': 'Myanmar',
    'single': true,
  };

  print(user['name']); //Sai Sai
  print(user['age']); //20

  user['phone'] = '09245456'; //new key,value pair
  user['age'] = 29; //update value

  print(user);

  print(user.containsKey('name')); // true
  print(user.containsKey('level')); //false

  //Spread operator ...
  var venue1 = {"Football", "Basketball"};
  var venue2 = {"Football", "Baseball"};

  var allSports1 = {venue1, venue2};
  print(allSports1); // {{Football, Basketball}, {Football, Baseball}}

  var allSports2 = {...venue1, ...venue2};
  print(allSports2); // {Football, Basketball, Baseball}
}
