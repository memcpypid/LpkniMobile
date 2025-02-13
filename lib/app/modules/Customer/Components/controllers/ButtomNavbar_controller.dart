import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class ButtomnavbarController extends GetxController {
  final box = GetStorage();
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value =
        box.read('selectedIndex') ?? 0; // Ambil nilai sebelumnya
  }

  void changePage(int index) {
    if (selectedIndex.value != index) {
      selectedIndex.value = index;
      box.write('selectedIndex', index); // Simpan state navbar
      switch (index) {
        case 0:
          Get.offAllNamed(Routes.HOMECUSTOMER);
          break;
        case 1:
          Get.offAllNamed(Routes.MENUCUSTOMER);
          break;
        case 2:
          Get.offAllNamed(Routes.CARTCUSTOMER);
          break;
        case 3:
          Get.offAllNamed(Routes.PROFILECUSTOMER);
          break;
        default:
          Get.offAllNamed(Routes.HOMECUSTOMER);
          break;
      }
    }
  }
}
