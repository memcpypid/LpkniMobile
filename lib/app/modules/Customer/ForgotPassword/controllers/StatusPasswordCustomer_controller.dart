import 'package:get/get.dart';

class StatuspasswordcustomerController extends GetxController {
  var isSuccess = true.obs;

  void setStatus(bool status) {
    isSuccess.value = status;
  }

  void proceed() {
    Get.offAllNamed('/login');
  }
}
