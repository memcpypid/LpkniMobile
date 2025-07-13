import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lpkni/app/data/Customer/Model/cart_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart'; // Pastikan ini diimpor
import 'package:lpkni/app/routes/app_pages.dart';

class CartcustomerView extends StatelessWidget {
  final CartcustomerController cartController = Get.find<CartcustomerController>();
  final ButtomnavbarController navbarController = Get.find<ButtomnavbarController>(); // Ambil controller navbar

  // Warna tema air mineral
  final Color primaryBlue = Color(0xFF86AEFF);
  final Color lightBlue = Color(0xFFB3D9FF);
  final Color darkBlue = Color(0xFF4A90E2);
  final Color accentBlue = Color(0xFF1E56A0);
  final Color successGreen = Color(0xFF4CAF50); // Untuk notifikasi sukses

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFF), // Background biru sangat muda
      appBar: _buildModernAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildCartItems(),
            ),
          ),
          _buildPromoCode(),
          _buildSummaryAndCheckout(),
          BottomNavBar(controller: navbarController), // Bottom Navigation Bar
        ],
      ),
    );
  }

  // Modern AppBar
  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBlue,
              darkBlue,
            ],
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                    onPressed: () => Get.back(),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Keranjang Saya",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                SizedBox(width: 48), // Placeholder for alignment
              ],
            ),
          ),
        ),
      ),
      toolbarHeight: 80, // Sesuaikan tinggi AppBar
    );
  }

  // Daftar Cart Items
  Widget _buildCartItems() {
    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        return _buildEmptyCartState();
      }
      return ListView.builder(
        itemCount: cartController.cartItems.length,
        itemBuilder: (context, index) {
          final product = cartController.cartItems[index];
          return _buildModernCartItem(product);
        },
      );
    });
  }

  // Empty Cart State
  Widget _buildEmptyCartState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: lightBlue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 60,
              color: primaryBlue,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Keranjang Anda Kosong",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Yuk, tambahkan air mineral favorit Anda!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Get.toNamed(Routes.MENUCUSTOMER); // Navigasi ke halaman menu
            },
            icon: Icon(Icons.add_shopping_cart, color: Colors.white),
            label: Text(
              "Mulai Belanja",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: accentBlue,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
            ),
          ),
        ],
      ),
    );
  }

  // Modern Cart Item
  Widget _buildModernCartItem(CartItem product) {
    return Slidable(
      key: ValueKey(product.name), // Gunakan ValueKey untuk Slidable
      endActionPane: ActionPane(
        motion: const DrawerMotion(), // Ganti ke DrawerMotion untuk efek lebih halus
        extentRatio: 0.25, // Sesuaikan lebar aksi
        children: [
          SlidableAction(
            onPressed: (context) {
              cartController.showDeleteConfirmation(product);
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever_rounded,
            label: 'Hapus',
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      child: Obx(() {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: primaryBlue.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                // Checkbox
                Checkbox(
                  value: cartController.selectedItems.contains(product),
                  onChanged: (value) {
                    cartController.toggleItemSelection(product);
                  },
                  activeColor: primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                SizedBox(width: 1),

                // Gambar Produk
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),

                // Detail Produk
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: darkBlue,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Rp${product.price.toStringAsFixed(0)} / item",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Quantity Control
                      Container(
                        decoration: BoxDecoration(
                          color: lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryBlue.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: accentBlue, size: 18),
                              onPressed: () => cartController.decreaseQuantity(product),
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(8),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                product.quantity.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: darkBlue,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: accentBlue, size: 18),
                              onPressed: () => cartController.increaseQuantity(product),
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.all(8),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Total Harga per Item
                Column(
                  children: [
                    Text(
                      "Rp${product.totalPrice.toStringAsFixed(0)}",
                      style: TextStyle(
                        color: accentBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(height: 4),
                    // Icon(Icons.water_drop, color: primaryBlue, size: 20),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Input Kode Promo
  Widget _buildPromoCode() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.local_offer_rounded, color: primaryBlue),
            hintText: "Masukkan kode promo Anda",
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            suffixIcon: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryBlue, darkBlue],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
                onPressed: () {
                  cartController.applyCoupon(10000); // Contoh diskon
                  Get.snackbar(
                    "Promo Diterapkan!",
                    "Diskon Rp10.000 berhasil ditambahkan.",
                    backgroundColor: successGreen.withOpacity(0.9),
                    colorText: Colors.white,
                    duration: Duration(seconds: 2),
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(16),
                    borderRadius: 12,
                    icon: Icon(Icons.check_circle, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Ringkasan Harga + Checkout Button
  Widget _buildSummaryAndCheckout() {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Item Dipilih:",
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                Text(
                  "${cartController.selectedItems.length} item",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: darkBlue),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Pembayaran:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkBlue),
                ),
                Text(
                  "Rp${cartController.selectedTotalAmount.value.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: accentBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: cartController.selectedItems.isNotEmpty
                  ? () {
                // Get.toNamed(Routes.CHECKOUTCUSTOMER); // Navigasi ke halaman checkout
                Get.snackbar(
                  "Proses Checkout",
                  "Anda akan diarahkan ke halaman pembayaran.",
                  backgroundColor: primaryBlue.withOpacity(0.9),
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                  snackPosition: SnackPosition.TOP,
                  margin: EdgeInsets.all(16),
                  borderRadius: 12,
                  icon: Icon(Icons.payment, color: Colors.white),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                backgroundColor: Colors.transparent, // Set transparent untuk gradient
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ).copyWith(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.white.withOpacity(0.2);
                    return null;
                  },
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: cartController.selectedItems.isNotEmpty
                        ? [primaryBlue, darkBlue]
                        : [Colors.grey[400]!, Colors.grey[600]!],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(minHeight: 50),
                  child: Obx(() => Text(
                    "Checkout (${cartController.selectedItems.length})",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}