import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/userProfile_model.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Profile/controllers/CustomerProfile_controller.dart';
import 'package:lpkni/app/modules/Customer/Profile/views/AddressForm_view.dart';

class ProfileDetailView extends StatelessWidget {
  final CustomerprofileController profileController =
      Get.find<CustomerprofileController>();
  final ButtomnavbarController navbarController =
      Get.find<ButtomnavbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF374151)),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Informasi Pribadi',
          style: TextStyle(
            color: Color(0xFF374151),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF1D4ED8)),
            onPressed: () {
              // Navigate to edit profile
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async { profileController.onRefresh();},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Header Section
              _buildProfileHeader(),
              const SizedBox(height: 24),

              // Personal Details Section
              _buildPersonalDetailsCard(),
              const SizedBox(height: 16),

              // Account Status Section
              _buildAccountStatusCard(),
              const SizedBox(height: 16),

              // Addresses Section
              _buildAddressesCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Obx(() {
      final userProfile = profileController.userData.value;
      if (userProfile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1D4ED8).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Profile Picture
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
            const SizedBox(height: 16),

            // Name with Verification
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${userProfile.dataUser!.namaDepan} ${userProfile.dataUser!.namaBelakang}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(width: 8),
                if (userProfile.verified)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1D4ED8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Role Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                userProfile.role.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF1D4ED8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPersonalDetailsCard() {
    return Obx(() {
      final userProfile = profileController.userData.value;
      if (userProfile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Personal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow(Icons.email_outlined, 'Email', userProfile.email),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.phone_outlined, 'No. WhatsApp',
                '${userProfile.dataUser!.noWa}'),
            // const SizedBox(height: 12),
            // _buildDetailRow(Icons.badge_outlined, 'User ID', userProfile.id),
          ],
        ),
      );
    });
  }

  Widget _buildAccountStatusCard() {
    return Obx(() {
      final userProfile = profileController.userData.value;
      if (userProfile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status Akun',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 16),

            // Verification Status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: userProfile.verified
                        ? const Color(0xFF1D4ED8).withOpacity(0.1)
                        : const Color(0xFFDC2626).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    userProfile.verified ? Icons.verified : Icons.warning,
                    color: userProfile.verified
                        ? const Color(0xFF1D4ED8)
                        : const Color(0xFFDC2626),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfile.verified
                            ? 'Terverifikasi'
                            : 'Belum Terverifikasi',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: userProfile.verified
                              ? const Color(0xFF1D4ED8)
                              : const Color(0xFFDC2626),
                        ),
                      ),
                      Text(
                        userProfile.verified
                            ? 'Akun Anda telah terverifikasi'
                            : 'Silakan verifikasi akun Anda',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // _buildDetailRow(Icons.login, 'Login Terakhir',
            //     _formatDate(userProfile.lastLogin)),
            // const SizedBox(height: 12),
            // _buildDetailRow(Icons.logout, 'Logout Terakhir',
            //     _formatDate(userProfile.lastLogout)),
            // const SizedBox(height: 12),
            _buildDetailRow(Icons.calendar_today, 'Bergabung Sejak',
                _formatDate(userProfile.createdAt)),
          ],
        ),
      );
    });
  }

  Widget _buildAddressesCard() {
    return Obx(() {
      final userProfile = profileController.userData.value;
      if (userProfile == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Alamat Tersimpan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF374151),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => Get.to(() => AddressFormView()),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Tambah'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF1D4ED8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...userProfile.dataUser!.alamatList
                .map((alamat) => _buildAddressItem(alamat)),
          ],
        ),
      );
    });
  }

  Widget _buildAddressItem(Alamat alamat) {
    return GestureDetector(
      onTap: () => showAddressDetail(Get.context!, alamat),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F9FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: alamat.isDefault
                ? const Color(0xFF1D4ED8)
                : const Color(0xFFE5E7EB),
            width: alamat.isDefault ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    alamat.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                if (alamat.isDefault)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D4ED8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Utama',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              alamat.detail,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${alamat.daerah}, ${alamat.wilayah}',
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAddressDetail(BuildContext context, Alamat alamat) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      alamat.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),
                  if (alamat.isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D4ED8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Utama",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(alamat.detail,
                  style: const TextStyle(color: Color(0xFF6B7280))),
              const SizedBox(height: 4),
              Text("${alamat.daerah}, ${alamat.wilayah}",
                  style: const TextStyle(color: Color(0xFF9CA3AF))),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Get.back();
                        Get.to(() => AddressFormView(alamat: alamat));
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        // panggil controller hapus alamat
                        // contoh:
                        // Get.find<AlamatController>().hapusAlamat(alamat.id);
                        Get.back();
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Hapus"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF1D4ED8).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF1D4ED8),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF374151),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "-";
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} '
          '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return dateString;
    }
  }
}
