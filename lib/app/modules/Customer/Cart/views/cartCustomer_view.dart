import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lpkni/app/data/Customer/Model/cart_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';

class CartcustomerView extends StatelessWidget {
  final CartcustomerController cartController =
      Get.find<CartcustomerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCartItems()), // ✅ Daftar item di keranjang
            _buildPromoCode(), // ✅ Input kode promo
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSummaryAndCheckout(), // ✅ Tombol Checkout (Sebelah kanan)
          BottomNavBar(controller: Get.find()), // ✅ Bottom Navigation
        ],
      ),
    );
  }

  // ✅ AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, color: Colors.black),
      //   onPressed: () => Get.back(),
      // ),
      title: const Text(
        "Keranjang Saya",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  // ✅ Daftar Cart Items
  Widget _buildCartItems() {
    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        return const Center(
          child: Text(
            "Keranjang kosong",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        );
      }

      return ListView.builder(
        itemCount: cartController.cartItems.length,
        itemBuilder: (context, index) {
          final product = cartController.cartItems[index];
          return _buildCartItemWithSwipe(product);
        },
      );
    });
  }

  // ✅ Slidable Cart Item dengan Checkbox
  Widget _buildCartItemWithSwipe(CartItem product) {
    return Slidable(
      key: Key(product.name),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              _showDeleteConfirmation(product);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Hapus',
            flex: 1,
          ),
        ],
      ),
      child: Obx(() {
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: cartController.selectedItems.contains(product),
                  onChanged: (value) {
                    cartController.toggleItemSelection(product);
                  },
                ),
                const SizedBox(width: 5),
                Image.asset(
                  product.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            title: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Rp${product.totalPrice.toStringAsFixed(0)}",
              style: const TextStyle(color: Colors.black54),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.green),
                  onPressed: () => cartController.decreaseQuantity(product),
                ),
                Text(product.quantity.toString().padLeft(2, '0')),
                IconButton(
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  onPressed: () => cartController.increaseQuantity(product),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ✅ Dialog Konfirmasi Hapus
  void _showDeleteConfirmation(CartItem product) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // **Warning Icon**
            const Icon(Icons.warning_amber_rounded,
                color: Colors.red, size: 50),
            const SizedBox(height: 10),

            // **Title**
            const Text(
              "Hapus Item dari Keranjang?",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 8),

            // **Subtitle**
            const Text(
              "Anda yakin ingin menghapus item ini dari keranjang?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // **Action Buttons**
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // **Cancel Button**
                Expanded(
                  child: TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Batal",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // **Delete Button**
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      cartController.removeFromCart(product);
                      Get.back();
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Hapus",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isDismissible: true,
    );
  }

  // ✅ Input Kode Promo
  Widget _buildPromoCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.local_offer, color: Colors.green),
          hintText: "Masukkan kode promo Anda",
          filled: true,
          fillColor: Colors.green.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.green),
            onPressed: () {
              cartController.applyCoupon(10000);
            },
          ),
        ),
      ),
    );
  }

  // ✅ Ringkasan Harga
  // ✅ Ringkasan Harga + Checkout Button dalam satu baris
  Widget _buildSummaryAndCheckout() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // ✅ Sejajarkan kiri & kanan
          children: [
            // **Total Amount**
            Text(
              "Total: Rp${cartController.selectedTotalAmount.value.toStringAsFixed(0)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            // **Checkout Button**
            ElevatedButton(
              onPressed: cartController.selectedItems.isNotEmpty
                  ? () {
                      print(
                          "Checkout with ${cartController.selectedItems.length} items");
                    }
                  : null, // ✅ Disabled jika tidak ada item
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                backgroundColor: cartController.selectedItems.isNotEmpty
                    ? Colors.green
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Obx(() => Text(
                    "Checkout (${cartController.selectedItems.length})",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      );
    });
  }
}
