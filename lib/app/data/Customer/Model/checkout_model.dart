import 'package:lpkni/app/data/Customer/Model/cart_model.dart';

class Checkout {
  final String productId;
  final String namaProduk;
  final String namaGudang;
  final String gudangId;
  final int quantity;
  String? keranjangId;
  String? keranjangIdItemId;

  Checkout({
    required this.productId,
    required this.namaProduk,
    required this.namaGudang,
    required this.gudangId,
    required this.quantity,
    this.keranjangId,
    this.keranjangIdItemId,
  });

  factory Checkout.fromJson(Map<String, dynamic> json) {
    return Checkout(
      productId: json["produk_id"],
      namaProduk: json["nama_produk"],
      namaGudang: json["nama_gudang"],
      gudangId: json["gudang_id"],
      quantity: json["quantity"],
      keranjangId: json["keranjang_id"],
      keranjangIdItemId: json["keranjang_item_id"],
    );
  }

  /// ✅ lebih bagus pakai static
  static List<Checkout> fromCartData(List<CartData> cartData) {
    return cartData.expand((cart) {
      return cart.items!.map((item) {
        return Checkout.fromCartItem(
          item,
          namaGudang: cart.gudang.nama,
          gudangId: cart.gudang.id,
        );
      }).toList();
    }).toList();
  }

  factory Checkout.fromCartItem(
    CartItem item, {
    required String namaGudang,
    required String gudangId,
  }) {
    return Checkout(
      productId: item.produkId,
      namaProduk: item.produk.nama,
      namaGudang: namaGudang,
      gudangId: gudangId,
      quantity: item.quantity,
      keranjangId: item.keranjangId,
      keranjangIdItemId: item.id,
    );
  }

  // @override
  // String toString() {
  //   return 'Checkout(productId: $productId, namaProduk: $namaProduk, namaGudang: $namaGudang, gudangId: $gudangId, quantity: $quantity, keranjangId: $keranjangId, keranjangItemId: $keranjangIdItemId)';
  // }

  /// ✅ tambahkan toJson supaya bisa langsung kirim ke API checkout
  Map<String, dynamic> toJson() {
    return {
      "produk_id": productId,
      "nama_produk": namaProduk,
      "nama_gudang": namaGudang,
      "gudang_id": gudangId,
      "quantity": quantity,
      "keranjang_id": keranjangId!,
      "keranjang_item_id": keranjangIdItemId!,
    };
  }
}

class CheckoutResponse {
  final List<CheckoutData> checkout;
  final int grandTotal;
  final String message;
  final int statusCode;

  CheckoutResponse({
    required this.checkout,
    required this.grandTotal,
    required this.message,
    required this.statusCode,
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    // print(">> CheckoutResponse.fromJson input: $json");

    final data = json["data"] ?? {};
    // print(">> data: $data");
    // print(">> checkout: ${data["checkout"]}");
    // print(">> checkout runtimeType: ${data["checkout"].runtimeType}");

    return CheckoutResponse(
      checkout: (data["checkout"] as List)
          .map((e) => CheckoutData.fromJson(e))
          .toList(),
      grandTotal: data["grand_total"] ?? 0,
      message: json["message"] ?? "",
      statusCode: json["status_code"] ?? 0,
    );
  }
}

class CheckoutData {
  final Gudang gudang;
  final List<CheckoutItem> items;

  CheckoutData({
    required this.gudang,
    required this.items,
  });

  factory CheckoutData.fromJson(Map<String, dynamic> json) {
    return CheckoutData(
      gudang: Gudang.fromJson(json["gudang"]),
      items: (json["items"] as List).map((e) => CheckoutItem.fromJson(e)).toList(),
    );
  }
}

class Gudang {
  final String id;
  final String nama;
  final String alamat;

  Gudang({
    required this.id,
    required this.nama,
    required this.alamat,
  });

  factory Gudang.fromJson(Map<String, dynamic> json) {
    return Gudang(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
    );
  }
}

class CheckoutItem {
  final String id;
  final String nama;
  final int harga;
  final int quantity;
  final int subtotal;
  final String kategori;
  final String kemasan;
  final String satuan;
  final String sku;
  final int isi;
  final String keranjangId;
  final String keranjangItemId;
  final List<FotoProduk> fotoProduk;

  CheckoutItem({
    required this.id,
    required this.nama,
    required this.harga,
    required this.quantity,
    required this.subtotal,
    required this.kategori,
    required this.kemasan,
    required this.satuan,
    required this.sku,
    required this.isi,
    required this.keranjangId,
    required this.keranjangItemId,
    required this.fotoProduk,
  });

  factory CheckoutItem.fromJson(Map<String, dynamic> json) {
    return CheckoutItem(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      quantity: json['quantity'],
      subtotal: json['subtotal'],
      kategori: json['kategori'],
      kemasan: json['kemasan'],
      satuan: json['satuan'],
      sku: json['sku'],
      isi: json['isi'],
      keranjangId: json['keranjang_id'],
      keranjangItemId: json['keranjang_item_id'],
      fotoProduk: (json['foto_produk'] as List)
          .map((e) => FotoProduk.fromJson(e))
          .toList(),
    );
  }
}

class FotoProduk {
  final String id;
  final String produkId;
  final String url;
  final bool isUtama;
  final String createdAt;
  final String updatedAt;

  FotoProduk({
    required this.id,
    required this.produkId,
    required this.url,
    required this.isUtama,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FotoProduk.fromJson(Map<String, dynamic> json) {
    return FotoProduk(
      id: json['id'],
      produkId: json['produk_id'],
      url: json['url'],
      isUtama: json['is_utama'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
