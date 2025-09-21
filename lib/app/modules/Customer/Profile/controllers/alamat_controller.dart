import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lpkni/app/data/Customer/Model/address_model.dart';
import 'package:lpkni/app/data/Customer/Model/userProfile_model.dart';
import 'package:lpkni/app/services/auth_service.dart';
import 'package:lpkni/app/services/api_service.dart';
// import 'package:lpkni/app/data/Model/alamat_model.dart';

class AlamatController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final ApiService api = Get.find<ApiService>();

  // Form field
  final TextEditingController labelController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  double? latitudeValue;
  double? longitudeValue;

  var wilayahList = <Map<String, dynamic>>[].obs;
  var daerahList = <Map<String, dynamic>>[].obs;

  var selectAlamatId = "".obs;
  var selectedWilayahId = "".obs;
  var selectedDaerahId = "".obs;
  var selectedDefault = false.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWilayah();
  }

  Future<void> initAlamatEdit(Alamat alamat) async {
    // Pastikan list wilayah sudah ada

    if (wilayahList.isEmpty) {
      await loadWilayah();
    }

    // Set wilayah
    // if (alamat.wilayahId) {
    //   selectedWilayahId.value = alamat.wilayahId;

    //   // Load daerah berdasarkan wilayah
    //   await loadDaerah(alamat.wilayahId);

    //   // Set daerah
    //   if (alamat.daerahId.isNotEmpty) {
    //     selectedDaerahId.value = alamat.daerahId;
    //     selectedDefault.value = alamat.isDefault;
    //   }
    // }

    // Set koordinat
    latitudeValue = double.tryParse(alamat.latitude.toString() ?? "");
    longitudeValue = double.tryParse(alamat.longitude.toString() ?? "");

    // Prefill text field
    labelController.text = alamat.label;
    detailController.text = alamat.detail;
  }

  Future<void> loadWilayah() async {
    try {
      final data = await api.getWilayah();
      wilayahList.value = List<Map<String, dynamic>>.from(data["data"]);
      // selectedDaerahId.value = "";
      // log("Wilayah List: ${wilayahList.map((w) => "${w['id']} - ${w['nama_wilayah']}").toList()}");
      // log("wilayah list raw: ${wilayahList.map((f) => "$f").toList()}");
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat wilayah: $e");
    }
  }

  Future<void> loadDaerah(String wilayahId) async {
    try {
      final data = await api.getDaerahByWilayah(wilayahId);
      daerahList.value = List<Map<String, dynamic>>.from(data["data"]);
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat daerah: $e");
    }
  }

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Lokasi Nonaktif", "Aktifkan GPS terlebih dahulu");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Izin Ditolak", "Tidak bisa akses lokasi tanpa izin");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
            "Izin Permanen Ditolak", "Aktifkan lokasi di pengaturan aplikasi");
        return;
      }

      // ✅ Ambil koordinat
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitudeValue = position.latitude;
      longitudeValue = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        detailController.text =
            "${place.thoroughfare} ${place.subThoroughfare}, "
            "${place.subLocality}, ${place.locality}, "
            "${place.postalCode}, ${place.country}";

        // Auto Wilayah
        final wilayah = wilayahList.firstWhereOrNull((w) =>
            place.administrativeArea
                ?.toLowerCase()
                .contains(w["nama_wilayah"].toString().toLowerCase()) ??
            false);

        if (wilayah != null) {
          selectedWilayahId.value = wilayah["id"].toString();
          await loadDaerah(selectedWilayahId.value);

          String daerahFromGps = normalizeGeo(place.subAdministrativeArea);

          final daerah = daerahList.firstWhereOrNull((d) {
            final namaDaerah = normalizeApi( d["nama_daerah"].toString());
            return namaDaerah == daerahFromGps;
            // return (place.subAdministrativeArea ?? "")
            //     .toLowerCase()
            //     .contains(namaDaerah);
          });

          if (daerah != null) {
            selectedDaerahId.value = daerah["id"].toString();
          } else {
            selectedDaerahId.value = ""; // biar aman kalau gak ketemu
          }
        }
      }
    } catch (e) {
      log("Error lokasi: $e");
      Get.snackbar("Error", "Gagal mendapatkan lokasi");
    }
    isLoading.value = false;
  }

  String normalizeGeo(String? name) {
    if (name == null) return "";

    return name
        .toLowerCase()
        .replaceAll("kabupaten", "kab.")
        .replaceAll("kota administrasi", "kota")
        .replaceAll("kota", "kota")
        .trim();
  }

  String normalizeApi(String? name) {
    if (name == null) return "";

    return name
        .toLowerCase()
        .replaceAll("kab.", "kab.")
        .replaceAll("kota", "kota")
        .trim();
  }

  Future<void> simpanAlamat() async {
    try {
      final label = labelController.text.trim();
      final detail = detailController.text.trim();

      if (label.isEmpty ||
          detail.isEmpty ||
          selectedWilayahId.value.isEmpty ||
          selectedDaerahId.value.isEmpty) {
        Get.snackbar("Error", "Semua kolom wajib diisi");
        return;
      }

      final alamat = AlamatInputUpdate(
        label: label,
        detail: detail,
        isDefault: true,
        daerahId: selectedDaerahId.value,
        wilayahId: selectedWilayahId.value,
        latitude: latitudeValue,
        longitude: longitudeValue,
      );

      await auth.createAlamat(alamat);

      Get.snackbar("Sukses", "Alamat berhasil disimpan");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      log("Error: $e");
    }
  }

  Future<void> updateAlamat(AlamatInputUpdate alamat, idAlamat) async {
    
    try {
      await auth.updateAlamat(idAlamat, alamat);
      return ;
    } catch (e) {
      Get.snackbar("Kesalahan", e.toString());
      throw Exception("gagal memperbarui alamat ${e}");
    }
  }

  Future<void> hapusAlamat(idAlamat) async {
    try {
      await auth.deleteAlamat(idAlamat);
      print("sukses hapus alamat");
      return;
    } catch (e) {
      print("gagal hapus alamat $e");
      Get.snackbar("kesalahan", e.toString());
    }
  }
}
