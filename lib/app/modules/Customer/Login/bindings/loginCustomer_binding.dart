import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Login/controllers/loginCustomer_controller.dart';

class LogincustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogincustomerController>(
      () => LogincustomerController(),
    );
  }
}
