import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/cart_model.dart';
import 'package:lpkni/app/data/Customer/Model/checkout_model.dart' hide Gudang;
import 'package:lpkni/app/modules/Customer/Profile/controllers/CustomerProfile_controller.dart';
import 'package:lpkni/app/services/api_service.dart';
import 'dart:developer';

class CartcustomerController extends GetxController {
  late CustomerprofileController pCont = Get.put(CustomerprofileController());
  late ApiService api;
  var cartItems = <CartItem>[].obs;
  var cartData = <CartData>[].obs;
  var gudang = <Gudang>[].obs;
  var selectedItems = <CartItem>[].obs;
  var isAllSelected = false.obs;
  var subtotal = 0.0.obs;
  var selectedSubtotal = 0.0.obs;
  var deliveryFee = 0.0.obs;
  var discount = 0.0.obs;
  var totalAmount = 0.0.obs;
  var selectedTotalAmount = 0.0.obs;
  var isSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();
    api = Get.find<ApiService>();
    fetchCart(); // ✅ load cart dari API saat init
  }

  void refresh(){
    fetchCart();
  }

  /// ✅ Ambil data keranjang dari API
  Future<void> fetchCart() async {
    print("fetching cart....");
    try {
      log("Fetching cart data from API...");
      final result = await api.getItemCart(); // ✅ ini CartResponse
      final data = result.data;
      log("data keranjang: ${jsonEncode(result)}");
      if(data != null){

      cartData.assignAll(data);
      }

      calculateTotal();
    } catch (e) {
      print("Kesalahan, Gagal mengambil keranjang: $e");
      Get.snackbar("Kesalahan", "Gagal mengambil keranjang: $e");
    }
  }

  var checkoutList = <Checkout>[].obs;

  /// ✅ Tambah item ke keranjang
  Future<void> addToCart(String productID, String gudangID, int qty) async {
    try {
      final result = await api.addToCart(productID, gudangID, qty);
      if (result["status_code"] == 200) {
        isSuccess.value = true;
        await fetchCart(); // refresh isi keranjang
      } else {
        Get.snackbar("Kesalahan Sistem", "Produk gagal dimasukkan.");
      }
    } catch (e) {
      Get.snackbar("Kesalahan", "Gagal memasukkan produk: $e");
    }
  }

  /// ✅ Hapus item dari keranjang
  Future<void> removeFromCart(CartItem item) async {
    try {
      await api.removeFromCart(item.id);
      cartItems.remove(item);
      selectedItems.remove(item);
      calculateTotal();
      refresh();
    } catch (e) {
      Get.snackbar("Kesalahan", "Gagal menghapus produk: $e");
    }
  }

  /// ✅ Tambah jumlah item
  Future<void> increaseQuantity(CartItem item) async {
    try {
      final newQty = item.quantity + 1;
      await api.updateQty(item.id, newQty);
      item.quantity = newQty;
      item.subtotal = newQty * item.produk.harga; // update subtotal lokal
      cartItems.refresh();
      calculateTotal();
      refresh();
    } catch (e) {
      Get.snackbar("Kesalahan", "Gagal menambah jumlah: $e");
    }
  }

  /// ✅ Kurangi jumlah item
  Future<void> decreaseQuantity(CartItem item) async {
    try {
      final newQty = item.quantity - 1;
      if (newQty <= 0) {
        // await removeFromCart(item);
        showDeleteConfirmation(item);
      } else {
        await api.updateQty(item.id, newQty);
        item.quantity = newQty;
        item.subtotal = newQty * item.produk.harga;
        cartItems.refresh();
        calculateTotal();
        refresh();
        // await fetchCart();
      }
    } catch (e) {
      Get.snackbar("Kesalahan", "Gagal mengurangi jumlah: $e");
    }
  }

  /// ✅ Terapkan diskon
  void applyCoupon(double discountAmount) {
    discount.value = discountAmount;
    calculateTotal();
  }

  /// ✅ Pilih / Batalkan pilih item
  void toggleItemSelection(CartItem item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    isAllSelected.value = selectedItems.length == cartItems.length;
    calculateTotal();
  }

  /// ✅ Pilih semua / batal pilih semua
  void toggleSelectAll(bool value) {
    if (value) {
      selectedItems.assignAll(cartItems);
    } else {
      selectedItems.clear();
    }
    isAllSelected.value = value;
    calculateTotal();
  }

  /// ✅ Hitung ulang total harga
  void calculateTotal() {
    subtotal.value = cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
    totalAmount.value = subtotal.value + deliveryFee.value - discount.value;

    selectedSubtotal.value =
        selectedItems.fold(0.0, (sum, item) => sum + item.subtotal);
    selectedTotalAmount.value =
        selectedSubtotal.value + deliveryFee.value - discount.value;
  }

  /// ✅ Checkout item yang dipilih
  void checkoutSelectedItems() async {
    if (selectedItems.isEmpty) {
      Get.snackbar("Checkout Gagal", "Pilih minimal satu item untuk checkout");
      return;
    }

    try {
      final checkouts = selectedItems.map((item) {
        // cari gudang asal dari cartData
        // CartData cartData;
        final parentCart = cartData.firstWhere(
          (cart) => cart.items!.contains(item),
          orElse: () =>
              throw Exception("Gudang tidak ditemukan untuk item ${item.id}"),
        );

        return Checkout.fromCartItem(
          item,
          namaGudang: parentCart.gudang.nama,
          gudangId: parentCart.gudang.id,
        );
      }).toList();

      checkoutList.assignAll(checkouts);
      // await api.checkOut(checkouts);
      // log("Checkout data: ${checkoutList.map((e) => e.toJson()).toList()}");
      // log("co data ${checkouts.toList()}");
      // log("co list: ${checkoutList.toJson().toString()}");

      // contoh kirim ke API
      // await api.checkOut(checkoutList.map((a) => a.toJson) );

      final result = await api.checkOut(checkoutList);
      // log("result : ${result.statusCode}");
      if (result.statusCode == 200) {
        // Get.snackbar("Berhasil", "Checkout berhasil (${checkoutList.length} item)");
        Get.toNamed('/checkout');
      }
    } catch (e) {
      log("Gagal, Checkout gagal: $e");
      Get.snackbar("Gagal", "Checkout gagal: $e");
    }
  }

  void showDeleteConfirmation(CartItem product) {
    Get.defaultDialog(
      title: "Hapus Produk",
      middleText:
          "Apakah Anda yakin ingin menghapus ${product.produk.nama} dari keranjang?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Colors.white,
      onConfirm: () {
        cartItems.remove(product);
        selectedItems.remove(product);
        removeFromCart(product);
        Get.back();
        Get.snackbar(
          "Produk Dihapus",
          "${product.produk.nama} ${product.produk.kemasan} berhasil dihapus dari keranjang.",
          backgroundColor: Colors.redAccent.withOpacity(0.9),
          colorText: Colors.white,
        );
        // refresh();
      },
    );
  }

  // Future<List> getCheckout
}
