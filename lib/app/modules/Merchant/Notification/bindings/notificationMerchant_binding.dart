import 'package:get/get.dart';
import 'package:lpkni/app/modules/Merchant/Notification/controllers/notificationMerchant_controller.dart';

class NotificationmerchantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationmerchantController>(
        () => NotificationmerchantController());
  }
}
