import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Notification/controllers/notificationCustomer_controller.dart';

class NotificationcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationcustomerController>(
        () => NotificationcustomerController());
  }
}
