import 'dart:io';
import 'dart:math';


///Reference string for payment
String getPaymentRef() {
  Random rand = Random();
  int number = rand.nextInt(200000);

  if (Platform.isAndroid) {
    return "AndroidRef1789$number";
  } else {
    return "IOSRef1789$number";
  }
}
