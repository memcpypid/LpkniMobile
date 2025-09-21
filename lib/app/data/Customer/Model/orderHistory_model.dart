class OrderHistory {
  final String id;
  final String userId;
  final String nomorFaktur;
  final OrderUser user;
  final String alamatId;
  final OrderAlamat alamat;
  final int totalHarga;
  final String status;
  final List<OrderItem> orderItems;
  final OrderPembayaran pembayaran;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderHistory({
    required this.id,
    required this.userId,
    required this.nomorFaktur,
    required this.user,
    required this.alamatId,
    required this.alamat,
    required this.totalHarga,
    required this.status,
    required this.orderItems,
    required this.pembayaran,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      id: json['id'],
      userId: json['user_id'],
      nomorFaktur: json['nomor_faktur'],
      user: OrderUser.fromJson(json['user']),
      alamatId: json['alamat_id'],
      alamat: OrderAlamat.fromJson(json['alamat']),
      totalHarga: json['total_harga'],
      status: json['status'],
      orderItems: (json['order_items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      pembayaran: OrderPembayaran.fromJson(json['pembayaran']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class OrderUser {
  final String userDataId;
  final String userId;
  final String namaDepan;
  final String namaBelakang;
  final String noWa;

  OrderUser({
    required this.userDataId,
    required this.userId,
    required this.namaDepan,
    required this.namaBelakang,
    required this.noWa,
  });

  factory OrderUser.fromJson(Map<String, dynamic> json) {
    return OrderUser(
      userDataId: json['user_data_id'],
      userId: json['userId'],
      namaDepan: json['nama_depan'],
      namaBelakang: json['nama_belakang'],
      noWa: json['no_wa'],
    );
  }
}

class OrderAlamat {
  final String id;
  final String label;
  final String detail;
  final bool isDefault;
  final OrderDaerah daerah;
  final OrderWilayah wilayah;

  OrderAlamat({
    required this.id,
    required this.label,
    required this.detail,
    required this.isDefault,
    required this.daerah,
    required this.wilayah,
  });

  factory OrderAlamat.fromJson(Map<String, dynamic> json) {
    return OrderAlamat(
      id: json['id'],
      label: json['label'],
      detail: json['detail'],
      isDefault: json['is_default'],
      daerah: OrderDaerah.fromJson(json['daerah']),
      wilayah: OrderWilayah.fromJson(json['wilayah']),
    );
  }
}

class OrderDaerah {
  final String id;
  final String namaDaerah;
  final String kodeDaerah;

  OrderDaerah({
    required this.id,
    required this.namaDaerah,
    required this.kodeDaerah,
  });

  factory OrderDaerah.fromJson(Map<String, dynamic> json) {
    return OrderDaerah(
      id: json['id'],
      namaDaerah: json['nama_daerah'],
      kodeDaerah: json['kode_daerah'],
    );
  }
}

class OrderWilayah {
  final String id;
  final String namaWilayah;
  final String kodeWilayah;

  OrderWilayah({
    required this.id,
    required this.namaWilayah,
    required this.kodeWilayah,
  });

  factory OrderWilayah.fromJson(Map<String, dynamic> json) {
    return OrderWilayah(
      id: json['id'],
      namaWilayah: json['nama_wilayah'],
      kodeWilayah: json['kode_wilayah'],
    );
  }
}

class OrderItem {
  final String id;
  final String orderId;
  final Produk produk;
  final Gudang gudang;
  final int jumlah;
  final int harga;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.produk,
    required this.gudang,
    required this.jumlah,
    required this.harga,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      produk: Produk.fromJson(json['produk']),
      gudang: Gudang.fromJson(json['gudang']),
      jumlah: json['jumlah'],
      harga: json['harga'],
    );
  }
}

class Produk {
  final String id;
  final String nama;
  final String slug;
  final String kemasan;
  final int jumlahIsi;
  final String satuan;
  final String kodeSku;
  final String kategori;
  final int harga;
  final List<FotoProduk> fotoProduk;

  Produk({
    required this.id,
    required this.nama,
    required this.slug,
    required this.kemasan,
    required this.jumlahIsi,
    required this.satuan,
    required this.kodeSku,
    required this.kategori,
    required this.harga,
    required this.fotoProduk,
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
      kategori: json['kategori'],
      harga: json['harga'],
      fotoProduk: (json['foto_produk'] as List)
          .map((e) => FotoProduk.fromJson(e))
          .toList(),
    );
  }
}

class FotoProduk {
  final String id;
  final String url;
  final bool isUtama;

  FotoProduk({
    required this.id,
    required this.url,
    required this.isUtama,
  });

  factory FotoProduk.fromJson(Map<String, dynamic> json) {
    return FotoProduk(
      id: json['id'],
      url: json['url'],
      isUtama: json['is_utama'],
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

class OrderPembayaran {
  final String id;
  final String nomorInvoice;
  final String tipe;
  final String status;
  final int totalBayar;
  final int jumlahBayar;

  OrderPembayaran({
    required this.id,
    required this.nomorInvoice,
    required this.tipe,
    required this.status,
    required this.totalBayar,
    required this.jumlahBayar,
  });

  factory OrderPembayaran.fromJson(Map<String, dynamic> json) {
    return OrderPembayaran(
      id: json['id'],
      nomorInvoice: json['nomor_invoice'] ?? '',
      tipe: json['tipe'] ?? '',
      status: json['status'] ?? '',
      totalBayar: json['total_bayar'],
      jumlahBayar: json['jumlah_bayar'],
    );
  }
}
