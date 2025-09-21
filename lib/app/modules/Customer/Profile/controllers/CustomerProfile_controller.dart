import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/data/Customer/Model/CustomerProfile_model.dart';
import 'package:lpkni/app/data/Customer/Model/userProfile_model.dart';
import 'package:lpkni/app/routes/app_pages.dart';
import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';

class CustomerprofileController extends GetxController {
  late final AuthService auth;
  late final ApiService api;
  @override
  void onInit() async {
    super.onInit();
    auth = Get.find<AuthService>();
    api = Get.find<ApiService>();
    box.remove("userProfile");
    await loadProfile();
  }

  Future<void> onRefresh() async {
    await loadProfile();
  }

  final box = GetStorage();
  var userData = Rxn<UserProfile>();
  var daftarAlamat = <Alamat>[].obs;

  var user2 = UserProfile2(
    name: "M. Darma Putra Ramadhan",
    email: "darmaputra443@gmail.com",
    profileImage: "assets/profil/profil.jpeg",
    language: "Indonesia (INA)",
    pushNotification: true,
    announcementNotification: false,
  ).obs;

  Future<void> loadProfile() async {
    log("inisiasi load profile...");
    // final auth = await authServiceFuture;

    try {
      final response = await auth.fetchUserProfile();

      print("=== FETCH USER PROFILE ===");
      print("Response: $response");
      print("data ${response.values}");

      final encryptedData = response["data"];
      // if (encryptedData == null) {
      //   print("Data kosong dari server");
      //   return;
      // }
      //
      // final decrypted = await decryptAES(encrypt edData);
      // log("data user devrypted: $decrypted");
      // log(message)
      final profile = UserProfile.fromJson(encryptedData);
      userData.value = profile;
    } catch (e) {
      print("Gagal memuat profile: $e");
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

  Future<void> logout() async {
    try {
      await auth.logout();

      if (!box.read('rememberMe')) {
        box.remove('email');
      }

      Get.offAllNamed(Routes.ONBOARDING);
    } catch (e) {
      print("Logout gagal: $e");
      Get.snackbar("Logout", "Gagal logout, silakan coba lagi");
    }
  }
}
