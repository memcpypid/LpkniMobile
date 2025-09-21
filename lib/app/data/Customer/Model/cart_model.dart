import 'dart:convert';
import 'dart:developer';

/// 1 Item dalam keranjang
class CartItem {
  final String id;
  final String keranjangId;
  final String produkId;
  int quantity;
  final int harga;
  int subtotal;
  final Produk produk;

  CartItem({
    required this.id,
    required this.keranjangId,
    required this.produkId,
    required this.quantity,
    required this.harga,
    required this.subtotal,
    required this.produk,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["id"],
      keranjangId: json["keranjang_id"],
      produkId: json["produk_id"],
      quantity: (json["quantity"] as num).toInt(),
      harga: (json["harga"] as num).toInt(),
      subtotal: (json["subtotal"] as num).toInt(),
      produk: Produk.fromJson(json["produk"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "keranjang_id": keranjangId,
        "produk_id": produkId,
        "quantity": quantity,
        "harga": harga,
        "subtotal": subtotal,
        "produk": produk.toJson(),
      };
}

/// Response API keranjang
class CartResponse {
  final List<CartData>? data;
  String? status;

  CartResponse({
    required this.data,
    this.status,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'] as List<dynamic>?;
    return CartResponse(
      data: rawData?.map((e) => CartData.fromJson(e)).toList(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data?.map((e) => e.toJson()).toList() ?? [],
        "status": status,
      };
}

/// Data per gudang (berisi gudang + items di gudang itu)
class CartData {
  final Gudang gudang;
  final List<CartItem>? items;

  CartData({
    required this.gudang,
    required this.items,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>?;
    return CartData(
      gudang: Gudang.fromJson(json['gudang']),
      items: rawItems?.map((e) => CartItem.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        "gudang": gudang.toJson(),
        "items": items?.map((e) => e.toJson()).toList(),
      };
}

/// Model Gudang dari response keranjang
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

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
      };
}

class Produk {
  final String id;
  final String nama;
  final String slug;
  final String kemasan;
  final int jumlahIsi;
  final String satuan;
  final String kodeSku;
  final String? deskripsi;
  final String kategori;
  final int harga;
  final List<FotoProduk> fotoProduk;
  final DateTime createdAt;
  final DateTime updatedAt;

  Produk({
    required this.id,
    required this.nama,
    required this.slug,
    required this.kemasan,
    required this.jumlahIsi,
    required this.satuan,
    required this.kodeSku,
    this.deskripsi,
    required this.kategori,
    required this.harga,
    required this.fotoProduk,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      nama: json['nama'],
      slug: json['slug'],
      kemasan: json['kemasan'],
      jumlahIsi: json['jumlah_isi'],
      satuan: json['satuan'],
      kodeSku: json['kode_sku'],
      deskripsi: json['deskripsi'] ?? ' ',
      kategori: json['kategori'],
      harga: json['harga'],
      fotoProduk: (json['foto_produk'] as List<dynamic>)
          .map((e) => FotoProduk.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'slug': slug,
      'kemasan': kemasan,
      'jumlah_isi': jumlahIsi,
      'satuan': satuan,
      'kode_sku': kodeSku,
      'deskripsi': deskripsi,
      'kategori': kategori,
      'harga': harga,
      'foto_produk': fotoProduk.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static Produk fromRawJson(String str) => Produk.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());
}

class FotoProduk {
  final String id;
  final String produkId;
  final String url;
  final bool isUtama;
  final DateTime createdAt;
  final DateTime updatedAt;

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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'produk_id': produkId,
      'url': url,
      'is_utama': isUtama,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
