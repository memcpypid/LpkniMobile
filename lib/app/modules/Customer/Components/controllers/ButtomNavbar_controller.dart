import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
          Get.offNamed('/home');
          break;
        case 1:
          Get.offNamed('/menu');
          break;
        case 2:
          Get.offNamed('/cart');
          break;
        case 3:
          Get.offNamed('/profile');
          break;
        default:
          Get.offNamed('/home');
      }
    }
  }
}
