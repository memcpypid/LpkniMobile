import 'dart:convert';
import 'dart:developer';

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
  final String gudangId;
  final String namaGudang;
  final String slugGudang;
  final String alamatGudang;
  final int stokAkhirBaik;
  final int jmlPenjualan;

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
    required this.gudangId,
    required this.namaGudang,
    required this.slugGudang,
    required this.alamatGudang,
    required this.stokAkhirBaik,
    required this.jmlPenjualan,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    // log("produkfromjson: $json");
    // log("DEBUG FOTO_PRODUK TYPE: ${json['foto_produk'].runtimeType}");

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
      gudangId: json['gudang_id'],
      namaGudang: json['nama_gudang'],
      slugGudang: json['slug_gudang'],
      alamatGudang: json['alamat_gudang'],
      stokAkhirBaik: json['stok_akhir_baik'],
      jmlPenjualan: json['jml_penjualan'],
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
      'gudang_id': gudangId,
      'nama_gudang': namaGudang,
      'slug_gudang': slugGudang,
      'alamat_gudang': alamatGudang,
      'stok_akhir_baik': stokAkhirBaik,
      'jml_penjualan': jmlPenjualan,
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
    // log("fotoproduk: $json");
    // log("DEBUG URL TYPE: ${json['url']}");

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
