import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Profile/controllers/CustomerProfile_controller.dart';

class CustomerprofileView extends StatelessWidget {
  final CustomerprofileController profileController =
      Get.find<CustomerprofileController>();
  final ButtomnavbarController navbarController =
      Get.find<ButtomnavbarController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF86AEFF),
        elevation: 0,
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 25,
            ),
            onPressed: () => profileController.Logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 2),
            _buildProfileOptions(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        controller: navbarController,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // ✅ Background Teal yang Full Lebar dan Lebih Tinggi
        Container(
          height: 60, // Sesuaikan agar setengah avatar tertutup
          width: double.infinity,
          color: Color(0xFF86AEFF),
        ),

        // ✅ Profil dengan Avatar & Info
        Column(
          children: [
            const SizedBox(height: 10), // Sesuaikan agar avatar masuk ke putih
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage(profileController.user2.value.profileImage),
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              profileController.user2.value.name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              profileController.user2.value.email,
              style: const TextStyle(fontSize: 14, color: Colors.black45),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileOptions() {
    return Column(
      children: [
        _buildSection("Akun Saya", [
          _buildListTile(Icons.person, "Informasi Pribadi", onTap: () {}),
          _buildListTile(Icons.language, "Bahasa",
              trailingText: profileController.user2.value.language,
              onTap: () {}),
          _buildListTile(Icons.privacy_tip, "Kebijakan Privasi", onTap: () {}),
          _buildListTile(Icons.settings, "Setting", onTap: () {}),
          _buildListTile(Icons.history, "Histori Pembelian", onTap: () {}),
        ]),
        _buildSection("Notifikasi", [
          _buildSwitchTile(
              "Push Notifikasi", profileController.user2.value.pushNotification,
              (value) {
            profileController.updateNotificationSetting(
                value, profileController.user2.value.announcementNotification);
          }),
          _buildSwitchTile("Pemberitahuan Notifications",
              profileController.user2.value.announcementNotification, (value) {
            profileController.updateNotificationSetting(
                profileController.user2.value.pushNotification, value);
          }),
        ]),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          const Divider(height: 1),
          Column(children: children),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title,
      {String? trailingText, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF86AEFF)),
      title: Text(title),
      trailing: trailingText != null
          ? Text(trailingText, style: const TextStyle(color: Colors.grey))
          : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      activeColor: Color(0xFF86AEFF),
      onChanged: onChanged,
    );
  }
}
