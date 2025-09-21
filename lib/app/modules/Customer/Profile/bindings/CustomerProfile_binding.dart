import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Profile/controllers/CustomerProfile_controller.dart';

class CustomerprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerprofileController>(() => CustomerprofileController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
  }
}

class DetailProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerprofileController>(() => CustomerprofileController());
    Get.lazyPut<ButtomnavbarController>(() => ButtomnavbarController());
  }
}