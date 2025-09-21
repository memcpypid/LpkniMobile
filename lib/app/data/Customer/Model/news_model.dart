import 'dart:convert';

class ArtikelResponse {
  final List<ArtikelModel> data;
  final String message;
  final int statusCode;

  ArtikelResponse({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory ArtikelResponse.fromJson(Map<String, dynamic> json) {
    return ArtikelResponse(
      data: (json['data'] as List)
          .map((item) => ArtikelModel.fromJson(item))
          .toList(),
      message: json['message'] ?? '',
      statusCode: json['status_code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data.map((e) => e.toJson()).toList(),
      "message": message,
      "status_code": statusCode,
    };
  }
}

class ArtikelModel {
  final String id;
  final String judul;
  final String slug;
  final String deskripsi1;
  final String deskripsi2;
  final String deskripsi3;
  final String kontenLengkap;
  final bool publish;
  final String status;
  final DateTime tanggalTerbit;
  final String kategori;
  final String wilayahId;
  final String daerahId;
  final String penulisId;
  final List<MediaModel> media;
  final int viewCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  ArtikelModel({
    required this.id,
    required this.judul,
    required this.slug,
    required this.deskripsi1,
    required this.deskripsi2,
    required this.deskripsi3,
    required this.kontenLengkap,
    required this.publish,
    required this.status,
    required this.tanggalTerbit,
    required this.kategori,
    required this.wilayahId,
    required this.daerahId,
    required this.penulisId,
    required this.media,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ArtikelModel.fromJson(Map<String, dynamic> json) {
    return ArtikelModel(
      id: json['id'] ?? '',
      judul: json['judul'] ?? '',
      slug: json['slug'] ?? '',
      deskripsi1: json['deskripsi1'] ?? '',
      deskripsi2: json['deskripsi2'] ?? '',
      deskripsi3: json['deskripsi3'] ?? '',
      kontenLengkap: json['konten_lengkap'] ?? '',
      publish: json['publish'] ?? false,
      status: json['status'] ?? '',
      tanggalTerbit: DateTime.tryParse(json['tanggal_terbit'] ?? '') ?? DateTime.now(),
      kategori: json['kategori'] ?? '',
      wilayahId: json['wilayah_id'] ?? '',
      daerahId: json['daerah_id'] ?? '',
      penulisId: json['penulis_id'] ?? '',
      media: (json['media'] as List? ?? [])
          .map((item) => MediaModel.fromJson(item))
          .toList(),
      viewCount: json['view_count'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "judul": judul,
      "slug": slug,
      "deskripsi1": deskripsi1,
      "deskripsi2": deskripsi2,
      "deskripsi3": deskripsi3,
      "konten_lengkap": kontenLengkap,
      "publish": publish,
      "status": status,
      "tanggal_terbit": tanggalTerbit.toIso8601String(),
      "kategori": kategori,
      "wilayah_id": wilayahId,
      "daerah_id": daerahId,
      "penulis_id": penulisId,
      "media": media.map((e) => e.toJson()).toList(),
      "view_count": viewCount,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}

class MediaModel {
  final String id;
  final String imageUrl;

  MediaModel({
    required this.id,
    required this.imageUrl,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image_url": imageUrl,
    };
  }
}
