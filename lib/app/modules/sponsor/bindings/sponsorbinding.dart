import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lpkni/app/modules/sponsor/controllers/sponsorcontroller.dart';

class Sponsorbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SponsorController>(() => SponsorController());
  }
}
