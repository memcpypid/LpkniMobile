class UserProfile {
  final String id;
  final String email;
  final String role;
  final bool verified;
  final String? tokenExpiredAt;
  final String? lastLogin;
  final String? lastLogout;
  final String? createdAt;
  final String? updatedAt;
  final DataUser? dataUser;

  UserProfile({
    required this.id,
    required this.email,
    required this.role,
    required this.verified,
    this.tokenExpiredAt,
    this.lastLogin,
    this.lastLogout,
    this.createdAt,
    this.updatedAt,
    this.dataUser,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["id"] ?? "",
      email: json["email"] ?? "",
      role: json["role"] ?? "",
      verified: json["verified"] ?? false,
      tokenExpiredAt: json["token_expired_at"],
      lastLogin: json["last_login"],
      lastLogout: json["last_logout"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      dataUser:
          json["data_user"] != null ? DataUser.fromJson(json["data_user"]) : null,
    );
  }
}

class DataUser {
  final String userDataId;
  final String userId;
  final String? namaDepan;
  final String? namaBelakang;
  final String? noWa;
  final List<Alamat> alamatList;

  DataUser({
    required this.userDataId,
    required this.userId,
    this.namaDepan,
    this.namaBelakang,
    this.noWa,
    required this.alamatList,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) {
    return DataUser(
      userDataId: json["user_data_id"] ?? "",
      userId: json["userId"] ?? "",
      namaDepan: json["nama_depan"],
      namaBelakang: json["nama_belakang"],
      noWa: json["no_wa"],
      alamatList: (json["alamat_list"] as List? ?? [])
          .map((e) => Alamat.fromJson(e))
          .toList(),
    );
  }
}

class Alamat {
  final String id;
  final String label;
  final String detail;
  final bool isDefault;
  final String? daerah;
  final String? wilayah;
  final String? daerahId;
  final String? wilayahId;
  final double? latitude;
  final double? longitude;

  Alamat({
    required this.id,
    required this.label,
    required this.detail,
    required this.isDefault,
    this.daerah,
    this.wilayah,
    this.daerahId,
    this.wilayahId,
    this.latitude,
    this.longitude,
  });

  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      id: json["id"] ?? "",
      label: json["label"] ?? "",
      detail: json["detail"] ?? "",
      isDefault: json["is_default"] ?? false,
      daerah: json["daerah"]?["nama_daerah"],
      wilayah: json["wilayah"]?["nama_wilayah"],
      daerahId: json["daerah"]?["id"],
      wilayahId: json["wilayah"]?["id"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  @override
  String toString() {
    return "Alamat(id: $id, label: $label, detail: $detail, daerah: $daerah, wilayah: $wilayah)";
  }
}

class Agent {
  final String? namaAgent;
  final String? alamatAgent;

  Agent({this.namaAgent, this.alamatAgent});

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
      namaAgent: json["nama_agent"],
      alamatAgent: json["alamat_agent"],
    );
  }
}

class Distributor {
  final String? namaDistributor;
  final String? alamatDistributor;

  Distributor({this.namaDistributor, this.alamatDistributor});

  factory Distributor.fromJson(Map<String, dynamic> json) {
    return Distributor(
      namaDistributor: json["nama_distributor"],
      alamatDistributor: json["alamat_distributor"],
    );
  }
}
