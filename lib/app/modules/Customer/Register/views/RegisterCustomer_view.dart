import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Register/controllers/RegisterCustomer_controller.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class RegistercustomerView extends GetView<RegisterCustomerController> {
  const RegistercustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daftar Akun",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1D4ED8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.person_add,
                                color: Color(0xFF3B82F6),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daftar Akun Baru',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Buat akun sesuai role anda',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Pribadi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // NAMA DEPAN
                        _buildTextField(
                          controller: controller.namaDepanController,
                          label: 'Nama Depan',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),

                        // NAMA BELAKANG
                        _buildTextField(
                          controller: controller.namaBelakangController,
                          label: 'Nama Belakang',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),

                        // EMAIL
                        _buildTextField(
                          controller: controller.emailController,
                          label: 'Email',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // PASSWORD
                        Obx(() => _buildTextField(
                              controller: controller.passwordController,
                              label: 'Password',
                              icon: Icons.lock_outline,
                              obscureText: controller.isPasswordHidden.value,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF64748B),
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            )),
                        const SizedBox(height: 16),

                        // NO WA
                        _buildTextField(
                          controller: controller.noWAController,
                          label: 'No WhatsApp',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Lokasi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Dropdown Wilayah
                        Obx(() => _buildDropdown(
                              value: controller.selectedWilayahId.value.isEmpty
                                  ? null
                                  : controller.selectedWilayahId.value,
                              label: "Pilih Wilayah",
                              icon: Icons.location_on_outlined,
                              items: controller.wilayahList
                                  .map((wilayah) => DropdownMenuItem(
                                        value: wilayah["id"].toString(),
                                        child: Text(
                                            wilayah["nama_wilayah"].toString()),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedWilayahId.value = value;
                                  controller.loadDaerah(value);
                                }
                              },
                            )),
                        const SizedBox(height: 16),

                        // Dropdown Daerah
                        Obx(() => _buildDropdown(
                              value: controller.selectedDaerahId.value.isEmpty
                                  ? null
                                  : controller.selectedDaerahId.value,
                              label: "Pilih Daerah",
                              icon: Icons.place_outlined,
                              items: controller.daerahList
                                  .map((daerah) => DropdownMenuItem(
                                        value: daerah["id"].toString(),
                                        child: Text(
                                            daerah["nama_daerah"].toString()),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedDaerahId.value = value;
                                }
                              },
                            )),
                        const SizedBox(height: 16),

                        // ALAMAT
                        _buildTextField(
                          controller: controller.alamatController,
                          label: 'Alamat Lengkap',
                          icon: Icons.home_outlined,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF3B82F6).withOpacity(0.2),
                            ),
                          ),
                          child: Obx(
                            () {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xFF3B82F6).withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF3B82F6)
                                        .withOpacity(0.2),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: controller.isLoading.value
                                      ? null // disable saat loading
                                      : () {
                                          controller.getCurrentLocation();
                                        },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (controller.isLoading.value) ...[
                                        SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Color(0xFF3B82F6),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        const Text(
                                          "Mengambil lokasi...",
                                          style: TextStyle(
                                            color: Color(0xFF3B82F6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ] else ...[
                                        const Icon(
                                          Icons.my_location,
                                          color: Color(0xFF3B82F6),
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          "Gunakan lokasi sekarang",
                                          style: TextStyle(
                                            color: Color(0xFF3B82F6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pilih Role',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // ROLE DROPDOWN
                        _buildDropdown(
                          value: controller.selectedRole.value,
                          label: "Pilih Role",
                          icon: Icons.work_outline,
                          items: const [
                            DropdownMenuItem(
                              value: "customer",
                              child: Text("Customer"),
                            ),
                            DropdownMenuItem(
                              value: "agen",
                              child: Text("Agen"),
                            ),
                            DropdownMenuItem(
                              value: "distributor",
                              child: Text("Distributor"),
                            ),
                          ],
                          onChanged: (value) {
                            controller.selectedRole.value = value ?? "customer";
                          },
                        ),
                        const SizedBox(height: 16),

                        // Tambahan field untuk AGEN
                        if (controller.selectedRole.value == "agen") ...[
                          _buildTextField(
                            controller: controller.namaAgenController,
                            label: 'Nama Agen',
                            icon: Icons.business_outlined,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: controller.alamatAgenController,
                            label: 'Alamat Agen',
                            icon: Icons.location_city_outlined,
                            maxLines: 2,
                          ),
                        ],

                        // Tambahan field untuk DISTRIBUTOR
                        if (controller.selectedRole.value == "distributor") ...[
                          _buildTextField(
                            controller: controller.namaDistributorController,
                            label: 'Nama Distributor',
                            icon: Icons.store_outlined,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            controller: controller.alamatDistributorController,
                            label: 'Alamat Distributor',
                            icon: Icons.warehouse_outlined,
                            maxLines: 2,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1D4ED8), Color(0xFF3B82F6)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3B82F6).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        final success = await controller.signUp();
                        if (success) {
                          Get.dialog(
                            AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Registrasi Berhasil",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                              content: const Text(
                                "Silahkan cek email untuk aktivasi akun.",
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                ),
                              ),
                              actions: [
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Get.offAllNamed(Routes.LOGINCUSTOMER);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF3B82F6),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                    ),
                                    child: const Text(
                                      "OK",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.05),
                        //     blurRadius: 8,
                        //     offset: const Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: GestureDetector(
                        onTap: () => Get.toNamed(Routes.LOGINCUSTOMER),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sudah punya akun? ',
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Masuk',
                              style: TextStyle(
                                color: Color(0xFF3B82F6),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF64748B),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        labelStyle: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 14,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String label,
    required IconData icon,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF64748B),
          size: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        labelStyle: const TextStyle(
          color: Color(0xFF64748B),
          fontSize: 14,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: items,
      onChanged: onChanged,
      dropdownColor: Colors.white,
      style: const TextStyle(
        color: Color(0xFF1E293B),
        fontSize: 14,
      ),
    );
  }
}
