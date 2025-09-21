import 'dart:developer';
// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';
// import 'package:lpkni/app/routes/app_pages.dart';

class RegisterCustomerController extends GetxController {
  final AuthService auth = Get.find<AuthService>();
  final ApiService api = Get.find<ApiService>();

  // 🔹 Field umum
  final TextEditingController namaDepanController = TextEditingController();
  final TextEditingController namaBelakangController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController noWAController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  double? latitudeValue;
  double? longitudeValue;

  // 🔹 Field tambahan untuk Agen
  final TextEditingController namaAgenController = TextEditingController();
  final TextEditingController alamatAgenController = TextEditingController();

  // 🔹 Field tambahan untuk Distributor
  final TextEditingController namaDistributorController =
      TextEditingController();
  final TextEditingController alamatDistributorController =
      TextEditingController();

  // 🔹 Dropdown role
  var selectedRole = "customer".obs;

  // 🔹 Untuk password visibility
  var isPasswordHidden = true.obs;
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // 🔹 Wilayah & Daerah Data
  var wilayahList = <Map<String, dynamic>>[].obs;
  var daerahList = <Map<String, dynamic>>[].obs;

  var selectedWilayahId = "".obs;
  var selectedDaerahId = "".obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWilayah();
  }

  Future<void> loadWilayah() async {
    log("loading wilayah...");
    try {
      final data = await api.getWilayah();
      // print("data wilayah: ${data}");
      // asumsi response.data = { "data": [ { "id": "...", "nama": "..." } ] }
      wilayahList.value = List<Map<String, dynamic>>.from(data["data"]);
      // for (var wilayah in wilayahList) {
      //   print("ID: ${wilayah['id']}, Nama: ${wilayah['nama']}");
      // }
    } catch (e) {
      print("error: $e");
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> loadDaerah(String wilayahId) async {
    log("loading daerah untuk wilayahId: $wilayahId");
    try {
      final data = await api.getDaerahByWilayah(wilayahId);
      daerahList.value = List<Map<String, dynamic>>.from(data["data"]);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  // 🔹 Fungsi Sign Up
  Future<bool> signUp() async {
    log("Starting sign up process...");
    try {
      final namaDepan = namaDepanController.text.trim();
      final namaBelakang = namaBelakangController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final noWa = noWAController.text.trim();
      final alamat = alamatController.text.trim();
      final role = selectedRole.value;
      final double latitude = latitudeValue ?? 0.0;
      final double longitude = longitudeValue ?? 0.0;

      if (namaDepan.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          noWa.isEmpty ||
          alamat.isEmpty ||
          selectedWilayahId.value.isEmpty ||
          selectedDaerahId.value.isEmpty) {
        Get.snackbar(
          'Error',
          'Semua kolom wajib diisi',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      await auth.register(
        email: email,
        password: password,
        role: role,
        namaDepan: namaDepan,
        namaBelakang: namaBelakang,
        noWa: noWa,
        alamat: alamat,
        daerahId: selectedDaerahId.value,
        wilayahId: selectedWilayahId.value,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        namaAgen: role == "agen" ? namaAgenController.text.trim() : null,
        alamatAgen: role == "agen" ? alamatAgenController.text.trim() : null,
        namaDistributor: role == "distributor"
            ? namaDistributorController.text.trim()
            : null,
        alamatDistributor: role == "distributor"
            ? alamatDistributorController.text.trim()
            : null,
      );

      return true; // sukses
    } on DioException catch (e) {
      log("DioException during sign up: $e");
      String errorMsg = "Gagal melakukan registrasi.";
      if (e.response != null && e.response?.data != null) {
        if (e.response?.data is Map<String, dynamic> &&
            e.response?.data["message"] != null) {
          errorMsg = e.response?.data["message"];
        } else if (e.response?.data is String) {
          errorMsg = e.response?.data;
        }
      }
      Get.snackbar(
        'Error',
        errorMsg,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      log("Error: $e");
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      log("Sign up process completed.");
    }
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

  Future<void> getCurrentLocation() async {
    isLoading.value = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Lokasi Nonaktif", "Aktifkan GPS di perangkat Anda.");
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Izin Ditolak", "Tidak bisa akses lokasi tanpa izin.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Izin Permanen Ditolak",
            "Silakan aktifkan lokasi di pengaturan aplikasi.");
        return;
      }

      // ✅ Dapat posisi
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // print("posisi: $position");
      latitudeValue = position.latitude;
      longitudeValue = position.longitude;

      // log("altitude: ${latitudeControler}, longitude ${longtitudeControler}");

      // 🔹 Ubah koordinat ke alamat
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        // Isi field alamat
        alamatController.text =
            "${place.thoroughfare} ${place.subThoroughfare}, "
            "${place.subLocality}, ${place.locality}, "
            // "${place.subAdministrativeArea}, ${place.administrativeArea} "
            "${place.postalCode}, ${place.country}";

        // Auto pilih wilayah
        final wilayah = wilayahList.firstWhereOrNull((w) =>
            place.administrativeArea
                ?.toLowerCase()
                .contains(w["nama_wilayah"].toString().toLowerCase()) ??
            false);

        if (wilayah != null) {
          selectedWilayahId.value = wilayah["id"].toString();
          await loadDaerah(selectedWilayahId.value);

          // log("placemark ${place.subThoroughfare}");

          // 🔹 Ambil nama dari geocoding
          String daerahFromGps = normalizeGeo(place.subAdministrativeArea);

          // 🔹 Cari kecocokan di API
          final daerah = daerahList.firstWhereOrNull((d) {
            final namaDaerah = normalizeApi(d["nama_daerah"].toString());
            return namaDaerah == daerahFromGps;
          });

          // log("daerah geo: ${daerahFromGps} daerah api ${daerah}");

          // Auto pilih daerah
          // final daerah = daerahList.firstWhereOrNull((d) =>
          //     place.locality
          //         ?.toLowerCase()
          //         .contains(d["nama_daerah"].toString().toLowerCase()) ??
          //     false);

          if (daerah != null) {
            selectedDaerahId.value = daerah["id"].toString();
          }
        }
      }
    } catch (e) {
      log("error: $e");
      Get.snackbar("Kesalahan", "Gagal mendapatkan lokasi");
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
