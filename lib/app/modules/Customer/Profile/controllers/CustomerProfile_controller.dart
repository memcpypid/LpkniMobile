import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/data/Customer/Model/CustomerProfile_model.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class CustomerprofileController extends GetxController {
  final box = GetStorage();
  var user2 = UserProfile(
    name: "M. Darma Putra Ramadhan",
    email: "darmaputra443@gmail.com",
    profileImage: "assets/profil/profil.jpeg",
    language: "Indonesia (INA)",
    pushNotification: true,
    announcementNotification: false,
  ).obs;
  @override
  void onInit() {
    super.onInit();
    box.remove("userProfile");
    loadProfile();
  }

  void loadProfile() {
    var storedProfile = box.read("userProfile");
    if (storedProfile != null) {
      user2.value = UserProfile.fromJson(storedProfile);
    }
  }

  void updateNotificationSetting(bool push, bool announcement) {
    user2.update((val) {
      val?.pushNotification = push;
      val?.announcementNotification = announcement;
    });
    saveProfile();
  }

  void saveProfile() {
    box.write("userProfile", user2.value.toJson());
  }

  void Logout() {
    Get.offAllNamed(Routes.ONBOARDING);
    box.remove('selectedIndex');
  }
}
