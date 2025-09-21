import 'dart:developer' as developer;

import 'package:get/get.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class ButtomnavbarController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _syncIndexWithRoute(); // cek halaman yg aktif, lalu sesuaikan index
  }

  void _syncIndexWithRoute() {
    developer.log("pindah ke->");
    developer.log("Current route: ${Get.currentRoute}", name: "ButtomnavbarController");
    switch (Get.currentRoute) {
      case Routes.HOMECUSTOMER:
        selectedIndex.value = 0;
        break;
      case Routes.MENUCUSTOMER:
        selectedIndex.value = 1;
        break;
      case Routes.CARTCUSTOMER:
        selectedIndex.value = 2;
        break;
      case Routes.PROFILECUSTOMER:
        selectedIndex.value = 3;
        break;
      default:
        selectedIndex.value = 0;
    }
    developer.log("Sync index -> ${selectedIndex.value}", name: "ButtomnavbarController");
  }

  void changePage(int index) {
    if (selectedIndex.value != index) {
      developer.log("Change page from ${selectedIndex.value} to $index", name: "ButtomnavbarController");
      selectedIndex.value = index;
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
    } else {
      developer.log("Page index $index sudah aktif", name: "ButtomnavbarController");
    }
  }
}
