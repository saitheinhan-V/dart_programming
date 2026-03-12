class Device {
  String brand;
  bool isPoweredOn = false;

  Device(this.brand);

  void powerOn() {
    isPoweredOn = true;
    print('$brand powered on');
  }
}

mixin Battery on Device {
  int batteryLevel = 100;

  void checkBattery() {
    print('$brand battery: $batteryLevel%');

    if (batteryLevel < 20 && isPoweredOn) {
      print('⚠️ Low battery! Consider power saving mode.');
    }
  }

  void consumeBattery(int amount) {
    batteryLevel -= amount;
    print('$brand: Battery reduced to $batteryLevel%');

    if (batteryLevel <= 0) {
      isPoweredOn = false;
      print('💀 $brand: Battery dead! Powering off...');
    }
  }
}

mixin Camera on Device {
  int megapixels = 48;

  void takePhoto() {
    if (isPoweredOn) {
      print('📸 $brand: Photo captured! ($megapixels MP)');
    } else {
      print('❌ $brand is powered off!');
    }
  }
}

class Smartphone extends Device with Battery, Camera {
  Smartphone(String brand) : super(brand);
}

void main() {
  final phone = Smartphone('iPhone');

  phone.powerOn();
  phone.checkBattery(); // iPhone battery: 100%

  phone.takePhoto(); // 📸 iPhone: Photo captured!
  phone.consumeBattery(30); // Battery reduced to 70%

  phone.consumeBattery(50); // Battery reduced to 20%
  phone.checkBattery(); // ⚠️ Low battery warning!

  phone.consumeBattery(25); // Battery dead! Powering off...
  phone.takePhoto(); // ❌ iPhone is powered off!
}
