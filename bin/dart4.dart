import 'dart:io';

enum Status { accepted, rejected }

enum Item {
  Empty(0, "Empty", 0),
  Mohingha(1, "Mohingha", 3000),
  Noodle(2, "Noodle", 4000),
  Rice(3, "Rice", 5000);

  final int code;
  final String lable;
  final int price;

  const Item(this.code, this.lable, this.price);
}

void main() {
  stdout.write("Welcome to ordering system\n");
  stdout.write("Please enter the following fields to make order\n");

  stdout.write("Code no of each food : 1 = Mohingha , 2 = Noodle, 3 = Rice\n");
  stdout.write("Enter food code no : ");
  final code = int.parse(stdin.readLineSync() ?? '0');
  stdout.write("Enter quantity : ");
  final qty = int.parse(stdin.readLineSync() ?? '0');
  stdout.write("Enter distance (greater than 0): ");
  final distance = int.parse(stdin.readLineSync() ?? '0');

  processOrder(item: checkItem(code), qty: qty, distance: distance);
}

void processOrder({
  required Item item,
  required int qty,
  required int distance,
}) {
  if (item.code == 0) {
    print("There is no food match with the code you have entered!");
    stdout.write("\nPlease try again! (y/n) : ");
    String value = stdin.readLineSync() ?? "";
    if (value.trim() != "") {
      if (value == "y") {
        main();
      } else if (value == "n") {
        return;
      }
    }
    return;
  }
  print("\nProcessing order for : $qty x ${item.lable}");

  var (status, :total, :deliveryFee, :message) = calculateOrder(
    price: item.price,
    quantity: qty,
    distance: distance,
  );

  print("Status : ${status.name}");
  print("Message : $message");

  if (checkStatus(distance)) {
    print("Delivery Fee : $deliveryFee Ks");
    print("Subtotal ($qty x ${item.price}) : ${total - deliveryFee} Ks");
    print("Total : $total Ks");
    print("================================");
  }
}

Item checkItem(int code) {
  switch (code) {
    case 1:
      return Item.Mohingha;
    case 2:
      return Item.Noodle;
    case 3:
      return Item.Rice;
    default:
      return Item.Empty;
  }
}

String findMessage(int distance) {
  return switch (distance) {
    <= 10 => 'Order confirmed!',
    > 10 => 'Too far away!',
    _ => "Order failed!",
  };
}

bool checkStatus(int distance) {
  return distance <= 10 ? true : false;
}

(Status status, {int total, int deliveryFee, String message}) calculateOrder({
  required int price,
  required int quantity,
  required int distance,
}) {
  if (!checkStatus(distance)) {
    return (
      Status.rejected,
      total: 0,
      deliveryFee: 0,
      message: findMessage(distance),
    );
  }

  int subtotal = price * quantity;
  int delivery = distance * 500;

  return (
    Status.accepted,
    total: subtotal + delivery,
    deliveryFee: delivery,
    message: findMessage(distance),
  );
}
