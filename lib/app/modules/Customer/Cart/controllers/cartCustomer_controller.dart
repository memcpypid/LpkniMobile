import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/data/Customer/Model/cart_model.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/CustomerDialog_widget.dart';

class CartcustomerController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var selectedItems = <CartItem>[].obs; // ✅ Menyimpan item yang dipilih
  var isAllSelected = false.obs; // ✅ Status pilih semua
  var subtotal = 0.0.obs;
  var selectedSubtotal = 0.0.obs; // ✅ Total hanya untuk item yang dipilih
  var deliveryFee = 0.0.obs;
  var discount = 0.0.obs;
  var totalAmount = 0.0.obs;
  var selectedTotalAmount = 0.0.obs; // ✅ Total hanya untuk item yang dipilih
  final box = GetStorage(); // ✅ Inisialisasi local storage

  @override
  void onInit() {
    super.onInit();
    loadCartFromStorage(); // ✅ Load data dari local storage saat controller dimulai
    calculateTotal();
  }

// ✅ Dialog Konfirmasi Hapus
  void showDeleteConfirmation(CartItem product) {
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
                      removeFromCart(product);
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

  // ✅ Tambahkan item ke keranjang dari FoodItem
  void addToCart(FoodItem foodItem) {
    var index =
        cartItems.indexWhere((element) => element.name == foodItem.name);
    if (index != -1) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem.fromFoodItem(foodItem));
    }
    saveCartToStorage();
    calculateTotal();
    showSuccessDialog();
  }

  // ✅ Hapus item dari keranjang
  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    selectedItems.remove(item); // ✅ Hapus juga dari list item yang dipilih
    saveCartToStorage();
    calculateTotal();
  }

  // ✅ Tambah jumlah item dalam keranjang
  void increaseQuantity(CartItem item) {
    item.quantity++;
    cartItems.refresh();
    saveCartToStorage();
    calculateTotal();
  }

  // ✅ Kurangi jumlah item dalam keranjang
  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.remove(item);
      selectedItems.remove(item);
    }
    cartItems.refresh();
    saveCartToStorage();
    calculateTotal();
  }

  // ✅ Terapkan diskon dari kode promo
  void applyCoupon(double discountAmount) {
    discount.value = discountAmount;
    saveCartToStorage();
    calculateTotal();
  }

  // ✅ Pilih / Batalkan Pilih Item
  void toggleItemSelection(CartItem item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    isAllSelected.value = selectedItems.length == cartItems.length;
    calculateTotal();
  }

  // ✅ Pilih / Batalkan Semua Item
  void toggleSelectAll(bool value) {
    if (value) {
      selectedItems.assignAll(cartItems);
    } else {
      selectedItems.clear();
    }
    isAllSelected.value = value;
    calculateTotal();
  }

  // ✅ Hitung ulang total harga
  void calculateTotal() {
    subtotal.value = cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    totalAmount.value = subtotal.value + deliveryFee.value - discount.value;
    // ✅ Hanya hitung total harga dari item yang dipilih
    selectedSubtotal.value =
        selectedItems.fold(0.0, (sum, item) => sum + item.totalPrice);
    selectedTotalAmount.value =
        selectedSubtotal.value + deliveryFee.value - discount.value;
  }

  // ✅ Simpan `cartItems` ke local storage
  void saveCartToStorage() {
    List<String> cartJson =
        cartItems.map((item) => jsonEncode(item.toJson())).toList();
    box.write('cartItems', cartJson);
  }

  // ✅ Load `cartItems` dari local storage saat aplikasi dibuka
  void loadCartFromStorage() {
    try {
      // ✅ Read the data safely, ensuring it returns a List<String>
      List<dynamic>? cartJson = box.read<List<dynamic>>('cartItems');

      // ✅ Check if the stored data is valid before proceeding
      // ignore: unnecessary_type_check
      if (cartJson != null && cartJson is List) {
        cartItems.assignAll(
          cartJson
              .map((item) {
                try {
                  return CartItem.fromJson(
                      jsonDecode(item)); // ✅ Try decoding each item
                } catch (e) {
                  print(
                      "Error decoding cart item: $e"); // ✅ Handle JSON parsing errors
                  return null;
                }
              })
              .whereType<
                  CartItem>() // ✅ Filter out any null values from failed parsing
              .toList(),
        );
      }
    } catch (e) {
      print("Error loading cart from storage: $e");
    }
  }

  // ✅ Checkout Item yang Dipilih
  void checkoutSelectedItems() {
    if (selectedItems.isNotEmpty) {
      print(
          "Checkout dengan ${selectedItems.length} item: ${selectedItems.map((e) => e.name).toList()}");
      // TODO: Tambahkan logika navigasi ke halaman checkout
    } else {
      Get.snackbar("Checkout Gagal", "Pilih minimal satu item untuk checkout",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
