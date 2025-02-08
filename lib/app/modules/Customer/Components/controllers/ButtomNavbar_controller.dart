import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/CartCustomer/views/cartCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Home/views/HomeCustomer_view.dart';

class ButtomnavbarController extends GetxController {
  var selectedIndex = 0.obs;

  final pages = [
    // CartcustomerView()
    // CartPageView(),
    // ProfilePageView(),
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
