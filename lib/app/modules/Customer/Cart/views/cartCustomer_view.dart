import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lpkni/app/data/Customer/Model/cart_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class CartcustomerView extends StatelessWidget {
  final CartcustomerController cartController =
      Get.find<CartcustomerController>();
  final ButtomnavbarController navbarController =
      Get.find<ButtomnavbarController>();

  // Warna tema air mineral yang konsisten
  final Color primaryBlue = const Color(0xFF86AEFF);
  final Color lightBlue = const Color(0xFFB3D9FF);
  final Color darkBlue = const Color(0xFF4A90E2);
  final Color accentBlue = const Color(0xFF1E56A0);
  final Color successGreen = const Color(0xFF4CAF50);
  final Color backgroundColor = const Color(0xFFF8FBFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildModernAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCartItems(),
            ),
          ),
          // _buildPromoCode(),
          _buildSummaryAndCheckout(),
          BottomNavBar(controller: navbarController),
        ],
      ),
    );
  }

  // Modern AppBar dengan styling konsisten
  PreferredSizeWidget _buildModernAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryBlue, darkBlue],
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Row(
              children: [
                _buildBackButton(),
                const Expanded(
                  child: Text(
                    "Keranjang Saya",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 44), // Balance for back button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Get.back(),
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
      ),
    );
  }

  // Daftar Cart Items dengan styling yang diperbaiki
  Widget _buildCartItems() {
    return Obx(() {
      if (cartController.cartData.isEmpty) {
        return _buildEmptyCartState();
      }

      return ListView.separated(
        itemCount: cartController.cartData.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final cartData = cartController.cartData[index];
          final gudang = cartData.gudang;
          final items = cartData.items;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGudangHeader(gudang.nama),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items!.length,
                  separatorBuilder: (context, index) => Divider(
                    color: lightBlue.withOpacity(0.3),
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  itemBuilder: (context, itemIndex) {
                    final product = items[itemIndex];
                    return _buildModernCartItem(product);
                  },
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildGudangHeader(String gudangName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            lightBlue.withOpacity(0.3),
            primaryBlue.withOpacity(0.1),
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.store_rounded,
            color: darkBlue,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            "Gudang: $gudangName",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  // Empty Cart State dengan styling yang diperbaiki
  Widget _buildEmptyCartState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightBlue.withOpacity(0.2),
                    primaryBlue.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 70,
                color: primaryBlue,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Keranjang Anda Kosong",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Yuk, tambahkan air mineral favorit Anda!\nMulai berbelanja sekarang untuk mendapatkan produk terbaik.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildShopButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildShopButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryBlue, accentBlue],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () => Get.offAllNamed(Routes.MENUCUSTOMER),
        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
        label: const Text(
          "Mulai Belanja",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  // Modern Cart Item dengan spacing yang konsisten
  Widget _buildModernCartItem(CartItem product) {
    final baseUrl = dotenv.env['BASE_URL'];
    
    return Slidable(
      key: ValueKey(product.produk.nama),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) => cartController.showDeleteConfirmation(product),
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever_rounded,
            icon: Icons.delete_forever_rounded,
            label: 'Hapus',
            borderRadius: BorderRadius.circular(16),
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      child: Obx(() {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCheckbox(product),
              const SizedBox(width: 12),
              _buildProductImage(baseUrl, product),
              const SizedBox(width: 16),
              Expanded(child: _buildProductDetails(product)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCheckbox(CartItem product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: cartController.selectedItems.contains(product) 
              ? primaryBlue 
              : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Checkbox(
        value: cartController.selectedItems.contains(product),
        onChanged: (value) => cartController.toggleItemSelection(product),
        activeColor: primaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

  Widget _buildProductImage(String? baseUrl, CartItem product) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          '${baseUrl}${product.produk.fotoProduk.first.url}',
          width: 85,
          height: 85,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                color: lightBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.image_not_supported_outlined,
                color: primaryBlue,
                size: 40,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductDetails(CartItem product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.produk.nama,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: darkBlue,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        _buildQuantityControl(product),
      ],
    );
  }

  Widget _buildQuantityControl(CartItem product) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: primaryBlue.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            icon: Icons.remove,
            onPressed: () => cartController.decreaseQuantity(product),
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 40),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              product.quantity.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          _buildQuantityButton(
            icon: Icons.add,
            onPressed: () => cartController.increaseQuantity(product),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: primaryBlue.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: accentBlue, size: 18),
        onPressed: onPressed,
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.all(8),
      ),
    );
  }

  // Input Kode Promo dengan styling yang diperbaiki
  // Widget _buildPromoCode() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: [
  //           BoxShadow(
  //             color: primaryBlue.withOpacity(0.1),
  //             blurRadius: 10,
  //             offset: const Offset(0, 4),
  //           ),
  //         ],
  //       ),
  //       child: TextField(
  //         decoration: InputDecoration(
  //           prefixIcon: Container(
  //             margin: const EdgeInsets.all(12),
  //             decoration: BoxDecoration(
  //               color: lightBlue.withOpacity(0.2),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Icon(Icons.local_offer_rounded, color: primaryBlue),
  //           ),
  //           hintText: "Masukkan kode promo Anda",
  //           hintStyle: TextStyle(
  //             color: Colors.grey[400],
  //             fontSize: 16,
  //           ),
  //           filled: true,
  //           fillColor: Colors.transparent,
  //           border: InputBorder.none,
  //           contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
  //           // suffixIcon: _buildPromoButton(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildPromoButton() {
  //   return Container(
  //     margin: const EdgeInsets.all(8),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(colors: [primaryBlue, darkBlue]),
  //       borderRadius: BorderRadius.circular(12),
  //       boxShadow: [
  //         BoxShadow(
  //           color: primaryBlue.withOpacity(0.3),
  //           blurRadius: 8,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: IconButton(
  //       icon: const Icon(
  //         Icons.arrow_forward_ios_rounded,
  //         color: Colors.white,
  //         size: 20,
  //       ),
  //       onPressed: () {
  //         cartController.applyCoupon(10000);
  //         _showSuccessSnackbar(
  //           "Promo Diterapkan!",
  //           "Diskon Rp10.000 berhasil ditambahkan.",
  //           Icons.check_circle,
  //         );
  //       },
  //     ),
  //   );
  // }

  // Summary dan Checkout dengan styling konsisten
  Widget _buildSummaryAndCheckout() {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildSummaryRow(
              "Total Item Dipilih:",
              "${cartController.selectedItems.length} item",
              isTotal: false,
            ),
            const SizedBox(height: 12),
            // _buildSummaryRow(
            //   "Total Pembayaran:",
            //   "Rp${cartController.selectedTotalAmount.value.toStringAsFixed(0)}",
            //   isTotal: true,
            // ),
            const SizedBox(height: 24),
            _buildCheckoutButton(),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryRow(String label, String value, {required bool isTotal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 15,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? darkBlue : Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 15,
            fontWeight: FontWeight.bold,
            color: isTotal ? accentBlue : darkBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    final bool isEnabled = cartController.selectedItems.isNotEmpty;
    
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isEnabled
              ? [primaryBlue, accentBlue]
              : [Colors.grey[300]!, Colors.grey[400]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                _showSuccessSnackbar(
                  "Proses Checkout",
                  "Anda akan diarahkan ke halaman pembayaran.",
                  Icons.payment,
                );
                cartController.checkoutSelectedItems();
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              "Checkout (${cartController.selectedItems.length})",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        )),
      ),
    );
  }

  void _showSuccessSnackbar(String title, String message, IconData icon) {
    Get.snackbar(
      title,
      message,
      backgroundColor: successGreen.withOpacity(0.9),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: Icon(icon, color: Colors.white),
      boxShadows: [
        BoxShadow(
          color: successGreen.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}