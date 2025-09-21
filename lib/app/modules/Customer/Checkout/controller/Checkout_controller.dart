import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/checkout_model.dart';
import 'package:lpkni/app/data/Customer/Model/order_model.dart';
import 'package:lpkni/app/data/Customer/Model/userProfile_model.dart';
import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';
import 'package:lpkni/app/services/encryption_service.dart';

class CheckoutController extends GetxController {
  late ApiService api = Get.find<ApiService>();
  late AuthService auth = Get.find<AuthService>();

  var alamat = <Alamat>[].obs;
  var checkoutList = <CheckoutData>[].obs;
  var grandTotal = 0.obs;
  var paymentMethod = [].obs;
  var shippingCost = 10000.obs;
  var adminFee = 1500.obs;
  var orders = <Order>[].obs;
  var selectedPaymentMethodId = "".obs;
  var selectedPaymentMethodName = "".obs;

  // Hanya satu alamat terpilih
  final selectedAddress = Rxn<Alamat>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    await getAlamat();
    await getCoData();
    await getPaymentMethod();
  }

  Future<void> getCoData() async {
    try {
      final checkoutResponse = await api.getCheckout();
      checkoutList.assignAll(checkoutResponse.checkout);
      grandTotal.value = checkoutResponse.grandTotal;
    } catch (e) {
      log("Error saat fetch data co: $e");
      Get.snackbar("Error", "Gagal ambil data checkout");
    }
  }

  Future<void> getPaymentMethod() async {
    try {
      final respone = await api.getMethodPayment();
      paymentMethod.value = respone['data'];
      log("payment method: $respone");
      log("payment method value:${paymentMethod.value}");
      // log("payment method value  id:${paymentMethod.value}");
    } catch (e) {
      log("Error saat ftech data payment method: $e");
    }
  }

  Future<void> getAlamat() async {
    log("inisiasi load alamat...");

    try {
      final response = await auth.fetchUserProfile();
      log("user data: $response");

      final userMap = response["data"] as Map<String, dynamic>;
      if (userMap.isEmpty) {
        log("Data kosong dari server");
        return;
      }

      final alamatList = userMap["data_user"]["alamat_list"] as List<dynamic>;

      final alamatModels = alamatList
          .map((e) => Alamat.fromJson(e as Map<String, dynamic>))
          .toList();

      alamat.assignAll(alamatModels);

      // cari default
      final defaultAlamat = alamat.firstWhereOrNull((a) => a.isDefault == true);

      if (defaultAlamat != null) {
        selectedAddress.value = defaultAlamat;
      } else if (alamat.isNotEmpty) {
        selectedAddress.value = alamat.first;
      }

      log("selected address: ${selectedAddress.value}");
    } catch (e, s) {
      log("Gagal memuat profile: $e");
      log("stacktrace: $s");
    }
  }

  // Ganti alamat secara manual
  void selectAddress(Alamat alamatBaru) {
    selectedAddress.value = alamatBaru;
  }

  // Payment Management
  // final selectedPaymentMethod = ''.obs;

  void selectPaymentMethod(String id, String name) {
    selectedPaymentMethodId.value = id;
    selectedPaymentMethodName.value = name;
  }

  void processCheckout() async {
    log("memproses pesanan...");

    // if (selectedPaymentMethodId.value.isEmpty) {
    //   Get.snackbar(
    //     'Error',
    //     'Silakan pilih metode pembayaran',
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    //   return;
    // }

    try {
      // Ambil data alamat yg dipilih
      final alamatId = selectedAddress.value?.id;
      if (alamatId == null) {
        Get.snackbar("Error", "Alamat belum dipilih");
        return;
      }

      log("selected payment method: ${selectedPaymentMethodId.value}");

      // Bangun model Order
      final order = Order(
        alamatId: alamatId,
        ongkir: shippingCost.value,
        detailMetodePembayaranId: selectedPaymentMethodId.value,
        itemsCheckout: checkoutList.map((data) {
          return OrderItemsCheckout(
            gudang: OrderGudang(
              id: data.gudang.id,
              nama: data.gudang.nama,
              alamat: data.gudang.alamat,
            ),
            items: data.items.map((item) {
              return OrderItem(
                id: item.id,
                nama: item.nama,
                sku: item.sku,
                kategori: item.kategori,
                kemasan: item.kemasan,
                satuan: item.satuan,
                isi: item.isi,
                harga: item.harga,
                quantity: item.quantity,
                subtotal: item.subtotal,
                keranjangId: item.keranjangId,
                keranjangItemId: item.keranjangItemId,
                fotoProduk: item.fotoProduk.map((f) {
                  return OrderFotoProduk(
                    id: f.id,
                    produkId: f.produkId,
                    url: f.url,
                    isUtama: f.isUtama,
                    createdAt: f.createdAt,
                    updatedAt: f.updatedAt,
                  );
                }).toList(),
              );
            }).toList(),
          );
        }).toList(),
      );

      // 🔎 log payload sebelum dikirim
      final payload = order.toJson();
      log("Payload Order yang dikirim ke server:\n${payload}");

      final response = await api.createOrder(order);
      log("Respon createOrder: $response");

      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF10B981), size: 24),
              SizedBox(width: 8),
              Text(
                'Pesanan Berhasil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          content: const Text(
            'Pesanan Anda sedang diproses. Kami akan mengirimkan notifikasi untuk update status pesanan.',
            style: TextStyle(color: Color(0xFF6B7280)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
                // Get.offAllNamed(Routes.ORDER_LIST);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      log("Error create order: $e");
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
