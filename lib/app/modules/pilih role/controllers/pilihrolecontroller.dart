import 'package:get/get.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class PilihRoleController extends GetxController {
  var selectedCategory = "".obs;

  void navigateToPage(String role) {
    selectedCategory.value = role;
    switch (role) {
      case 'Konsumen':
      //   Get.toNamed(Routes.KONSUMEN_PAGE);
      //   break;
      // case 'Pemilik Warung':
      //   Get.toNamed(Routes.PEMILIK_WARUNG_PAGE);
      //   break;
      // case 'Grosir':
      //   Get.toNamed(Routes.GROSIR_PAGE);
      //   break;
      case 'Sponsor':
        Get.toNamed(Routes.SPONSOR);
        break;
      default:
        break;
    }
  }
}
