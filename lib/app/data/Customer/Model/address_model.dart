class AlamatInputUpdate {
  final String label;
  final String detail;
  final bool isDefault;
  final String daerahId;
  final String wilayahId;
  final double? latitude;
  final double? longitude;

  AlamatInputUpdate({
    required this.label,
    required this.detail,
    required this.isDefault, 
    required this.daerahId,
    required this.wilayahId,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "detail": detail,
      "is_default": isDefault,
      "daerah_id": daerahId,
      "wilayah_id": wilayahId,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory AlamatInputUpdate.fromJson(Map<String, dynamic> json) {
    return AlamatInputUpdate(
      label: json['label'] ?? "",
      detail: json['detail'] ?? "",
      isDefault: json['is_default'] ?? false,
      daerahId: json['daerah_id'] ?? "",
      wilayahId: json['wilayah_id'] ?? "",
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }
}
