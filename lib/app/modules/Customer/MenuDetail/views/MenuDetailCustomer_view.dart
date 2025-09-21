import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/controllers/MenuDetailCustomer_controller.dart';

class MenudetailcustomerView extends StatelessWidget {
  late MenudetailcustomerController controller =
      Get.find<MenudetailcustomerController>();
  final Produk productItem;
  final baseUrl = dotenv.env['BASE_URL'];

  // Warna tema air mineral yang konsisten
  final Color primaryBlue = const Color(0xFF86AEFF);
  final Color lightBlue = const Color(0xFFB3D9FF);
  final Color darkBlue = const Color(0xFF4A90E2);
  final Color accentBlue = const Color(0xFF1E56A0);
  final Color successGreen = const Color(0xFF4CAF50);
  final Color backgroundColor = const Color(0xFFF8FBFF);

  MenudetailcustomerView({required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          _buildProductImage(),
          _buildBackButton(),
          _buildFavoriteButton(),
          _buildContentSheet(),
        ],
      ),
    );
  }

  // Gambar produk dengan gradient overlay
  Widget _buildProductImage() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              "$baseUrl${productItem.fotoProduk.first.url}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: lightBlue.withOpacity(0.3),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 80,
                    color: primaryBlue,
                  ),
                );
              },
            ),
            // Gradient overlay untuk readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tombol back dengan styling modern
  Widget _buildBackButton() {
    return Positioned(
      top: 50,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 22,
          ),
          onPressed: () => Get.back(),
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

  // Tombol favorite dengan animasi
  Widget _buildFavoriteButton() {
    return Positioned(
      top: 50,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              icon: Icon(
                controller.isFavorite.value
                    ? Icons.favorite
                    : Icons.favorite_border,
                color:
                    controller.isFavorite.value ? Colors.red : Colors.grey[600],
                size: 24,
              ),
              onPressed: controller.toggleFavorite,
              padding: const EdgeInsets.all(12),
            ),
          );
        }),
      ),
    );
  }

  // Content sheet dengan styling yang diperbaiki
  Widget _buildContentSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDragHandle(),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProductHeader(),
                      const SizedBox(height: 20),
                      _buildPriceSection(),
                      const SizedBox(height: 24),
                      _buildDescriptionSection(),
                      const SizedBox(height: 24),
                      _buildQuantitySection(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
              _buildBottomActions(),
            ],
          ),
        );
      },
    );
  }

  // Handle untuk drag gesture
  Widget _buildDragHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: 50,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // Header dengan nama produk dan chat
  Widget _buildProductHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productItem.nama,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              _buildProductBadge(),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _buildChatButton(),
      ],
    );
  }

  Widget _buildProductBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [lightBlue.withOpacity(0.3), primaryBlue.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: primaryBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        "Air Mineral Premium",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: darkBlue,
        ),
      ),
    );
  }

  Widget _buildChatButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [lightBlue.withOpacity(0.3), primaryBlue.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.chat_bubble_outline_rounded,
          color: accentBlue,
          size: 22,
        ),
        onPressed: () {
          // TODO: Navigasi ke Chat
          Get.snackbar(
            "Chat",
            "Fitur chat akan segera hadir",
            backgroundColor: primaryBlue.withOpacity(0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
          );
        },
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  // Bagian harga dengan styling menarik
  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            lightBlue.withOpacity(0.1),
            primaryBlue.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: accentBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Informasi Harga",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Untuk harga silahkan hubungi agen/gudang terdekat",
            style: TextStyle(
              fontSize: 16,
              color: accentBlue,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Bagian deskripsi dengan styling yang diperbaiki
  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.description_outlined,
              color: accentBlue,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "Deskripsi Produk",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: lightBlue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            productItem.deskripsi ?? "Deskripsi tidak tersedia",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  // Bagian quantity dengan styling modern
// Bagian quantity dengan kondisi stok kosong
  Widget _buildQuantitySection() {
    final bool isOutOfStock = (productItem.stokAkhirBaik ?? 0) <= 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              color: accentBlue,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "Jumlah Pesanan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (isOutOfStock)
          Center(
            child: Text(
              "Stok habis",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
              ),
            ),
          )
        else
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: primaryBlue.withOpacity(0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildQuantityButton(
                    icon: Icons.remove_rounded,
                    onPressed: controller.decreaseQuantity,
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 80),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    child: Obx(() {
                      return Text(
                        controller.quantity.value.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }),
                  ),
                  _buildQuantityButton(
                    icon: Icons.add_rounded,
                    onPressed: controller.increaseQuantity,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [lightBlue.withOpacity(0.3), primaryBlue.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: accentBlue,
          size: 24,
        ),
        onPressed: onPressed,
        padding: const EdgeInsets.all(12),
      ),
    );
  }

  // Bottom actions dengan styling premium
  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildAddToCartButton(),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildContactButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    final bool isOutOfStock = (productItem.stokAkhirBaik ?? 0) <= 0;

    return Container(
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryBlue, accentBlue],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: isOutOfStock
            ? null
            : () async{
              await controller.addToCart(productItem.id, productItem.gudangId, controller.quantity.value);
                Get.snackbar(
                  "Berhasil!",
                  "Produk ditambahkan ke pesanan",
                  backgroundColor: successGreen.withOpacity(0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                  margin: const EdgeInsets.all(16),
                  borderRadius: 12,
                  icon: const Icon(Icons.check_circle, color: Colors.white),
                  duration: const Duration(seconds: 2),
                );
              },
        icon: const Icon(
          Icons.add_shopping_cart_rounded,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          isOutOfStock ? "Stok Habis" : "Tambah Pesanan",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: primaryBlue.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Get.snackbar(
            "Kontak",
            "Menghubungkan ke agen terdekat...",
            backgroundColor: primaryBlue.withOpacity(0.9),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            icon: const Icon(Icons.phone, color: Colors.white),
            duration: const Duration(seconds: 2),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Icon(
          Icons.phone_rounded,
          color: accentBlue,
          size: 24,
        ),
      ),
    );
  }
}
