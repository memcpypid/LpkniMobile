class Order {
  final String alamatId;
  String? detailMetodePembayaranId;
  final List<OrderItemsCheckout> itemsCheckout;
  final int ongkir;

  Order({
    required this.alamatId,
    this.detailMetodePembayaranId,
    required this.itemsCheckout,
    required this.ongkir,
  });

  Map<String, dynamic> toJson() {
    return {
      "alamat_id": alamatId,
      // "detail_metode_pembayaran_id": detailMetodePembayaranId,
      "items_checkout": itemsCheckout.map((e) => e.toJson()).toList(),
      "ongkir": ongkir,
    };
  }
}

class OrderItemsCheckout {
  final OrderGudang gudang;
  final List<OrderItem> items;

  OrderItemsCheckout({
    required this.gudang,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      "gudang": gudang.toJson(),
      "items": items.map((e) => e.toJson()).toList(),
    };
  }
}

class OrderGudang {
  final String alamat;
  final String id;
  final String nama;

  OrderGudang({
    required this.alamat,
    required this.id,
    required this.nama,
  });

  Map<String, dynamic> toJson() {
    return {
      "alamat": alamat,
      "id": id,
      "nama": nama,
    };
  }
}

class OrderItem {
  final List<OrderFotoProduk> fotoProduk;
  final int harga;
  final String id;
  final int isi;
  final String kategori;
  final String kemasan;
  final String keranjangId;
  final String keranjangItemId;
  final String nama;
  final int quantity;
  final String satuan;
  final String sku;
  final int subtotal;

  OrderItem({
    required this.fotoProduk,
    required this.harga,
    required this.id,
    required this.isi,
    required this.kategori,
    required this.kemasan,
    required this.keranjangId,
    required this.keranjangItemId,
    required this.nama,
    required this.quantity,
    required this.satuan,
    required this.sku,
    required this.subtotal,
  });

  Map<String, dynamic> toJson() {
    return {
      "foto_produk": fotoProduk.map((e) => e.toJson()).toList(),
      "harga": harga,
      "id": id,
      "isi": isi,
      "kategori": kategori,
      "kemasan": kemasan,
      "keranjang_id": keranjangId,
      "keranjang_item_id": keranjangItemId,
      "nama": nama,
      "quantity": quantity,
      "satuan": satuan,
      "sku": sku,
      "subtotal": subtotal,
    };
  }
}

class OrderFotoProduk {
  final String id;
  final String produkId;
  final String url;
  final bool isUtama;
  final String createdAt;
  final String updatedAt;

  OrderFotoProduk({
    required this.id,
    required this.produkId,
    required this.url,
    required this.isUtama,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "produk_id": produkId,
      "url": url,
      "is_utama": isUtama,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
