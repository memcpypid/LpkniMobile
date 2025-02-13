import 'package:get/get.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class StatuspasswordcustomerController extends GetxController {
  var isSuccess = true.obs;

  void setStatus(bool status) {
    isSuccess.value = status;
  }

  void proceed() {
    Get.offAllNamed(Routes.LOGINCUSTOMER);
  }
}
