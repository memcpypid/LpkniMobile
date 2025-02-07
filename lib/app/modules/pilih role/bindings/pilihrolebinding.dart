import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lpkni/app/modules/pilih%20role/controllers/pilihrolecontroller.dart';

class PilihRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PilihRoleController>(() => PilihRoleController());
  }
}
