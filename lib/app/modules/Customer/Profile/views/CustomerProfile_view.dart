import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Profile/controllers/CustomerProfile_controller.dart';
import 'package:lpkni/app/modules/Customer/Profile/views/detailProfile_view.dart';
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
        // ✅ Hapus logout dari AppBar.actions
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 2),
            _buildProfileOptions(),
            const SizedBox(height: 10),
            _buildLogoutButton(), // ✅ Logout pindah ke paling bawah
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        controller: navbarController,
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Obx(() {
      final user = profileController.userData.value;
      if (user == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 60,
            width: double.infinity,
            color: Color(0xFF86AEFF),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1D4ED8).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${user.dataUser!.namaDepan} ${user.dataUser!.namaBelakang}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 14, color: Colors.black45),
              ),
              if (user.role == "distributor" || user.role == "agen")
                Text(
                  "${user.role.toUpperCase()} Qmas-m",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                  ),
                ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildProfileOptions() {
    return Column(
      children: [
        _buildSection("Akun Saya", [
          _buildListTile(Icons.person, "Informasi Pribadi", onTap: () {
            Get.to(() => ProfileDetailView());
          }),
          _buildListTile(Icons.history, "Histori Pembelian", onTap: () {
            Get.toNamed('/order-history');
          }),
          _buildListTile(Icons.privacy_tip, "Kebijakan Privasi", onTap: () {}),
        ]),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        onPressed: () => profileController.logout(),
      ),
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
      activeColor: Color(0xFF86AEFF),
      onChanged: onChanged,
    );
  }
}
