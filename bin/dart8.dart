class User {
  User({required this.name, required this.address});
  //User(this.name,this.address)

  final String name;
  final String address;

  int _saving = 100;

  int get saving => _saving;

  bool get canBuyHouse => _saving > 200;

  void addSaving(int amount) {
    if (amount > 0) {
      _saving += amount;
    }
  }

  //age
  int? _age;
  int? get age => _age;

  set age(int newValue) {
    if (newValue < 0) {
      throw ArgumentError("Age can't be minus");
    }
    _age = newValue;
  }

  //override toString
  @override
  String toString() {
    // TODO: implement toString
    return 'User(name: $name,age: $age,address: $address)';
  }
}

void main() {
  var user1 = User(name: 'Sai Sai', address: 'Yangon');
  //var user 1 = User('Sai Sai','Yangon');
  var user2 = User(name: 'Mg Mg', address: 'Mandalay');

  user1.addSaving(50);
  print(user1.saving); //150
  print(user1.canBuyHouse); //false

  user1.addSaving(100);
  print(user1.saving);
  print(user1.canBuyHouse); //true

  user1.age = 20;
  user2.age = 10;

  //override method
  print(user1.toString());
  print(user2.toString());
}
