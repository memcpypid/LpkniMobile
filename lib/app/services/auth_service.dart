import 'dart:async';
import 'dart:developer';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;
import 'package:lpkni/app/data/Customer/Model/address_model.dart';
import 'package:path_provider/path_provider.dart';

class AuthService {
  static String? baseUrl = dotenv.env['BASE_URL'];
  late Dio dio;
  late PersistCookieJar cookieJar;
  // Timer? _refreshTimer;

  AuthService._create(this.dio, this.cookieJar);

  /// Factory create
  static Future<AuthService> create() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = "${appDocDir.path}/.cookies";

    if (kDebugMode) {
      print("📂 Cookie disimpan di: $cookiePath");
      // print("baseUrl: $baseUrl");
    }

    final cookieJar = PersistCookieJar(
      ignoreExpires: false, // biar expiry dihormati
      storage: FileStorage(cookiePath),
    );

    final dio = Dio(BaseOptions(
      baseUrl: baseUrl!,
      headers: {"Content-Type": "application/json"},
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 120),
    ));

    dio.interceptors.add(CookieManager(cookieJar));
    // dio.interceptors.add(LogInterceptor(
    //   requestBody: true,
    //   responseBody: true,
    //   requestHeader: true,
    //   responseHeader: true,
    //   error: true,
    // ));

    // Bypass SSL sementara (debug only)
    if (!kReleaseMode) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      };
    }

    final service = AuthService._create(dio, cookieJar);
    service._addInterceptors();
    return service;
  }

  /// Tambah interceptor untuk handle token expired
  void _addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.path.contains('/api/ecommerce/auth/_login') ||
              options.path.contains('/api/ecommerce/auth/_register') ||
              // options.path.contains('/api/produk/penjualan') ||
              options.path.contains('/api/berita-content') ||
              options.path.contains('/api/wilayah') ||
              options.path.contains('/api/daerah') ||
              options.path.contains('/api/auth/_refresh-token')) {
            log("Skipping token check for ${options.path}");
            log("headers: ${options.headers}");
            log("data: ${options.data}");
            return handler.next(options); // lewati pengecekan token
          } 
          // else if (await isTokenExpired()) {
          //   log("req api to: ${options.path}");
          //   log("headers: ${options.headers}");
          //   log("data: ${options.data}");
          //   if (await isRefreshTokenExpired()) {
          //     await _forceLogout();
          //     return handler.reject(
          //       DioException(
          //         requestOptions: options,
          //         error: "Sesi habis, silakan login ulang",
          //       ),
          //     );
          //   } else {
          //     // await refreshToken();
          //   }
          // }
          handler.next(options);
        },
        onError: (error, handler) async {
          handleDioError(error);
          if (
              // error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            try {
              await refreshToken();
              final retryResponse = await dio.fetch(error.requestOptions);
              return handler.resolve(retryResponse);
            } catch (_) {
              await _forceLogout();
              return handler.reject(error);
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  void handleDioError(DioException e) {
    log("------ DIO ERROR ------");
    log("Type       : ${e.type}");
    log("Message    : ${e.message}");
    log("URL        : ${e.requestOptions.uri}");
    log("Method     : ${e.requestOptions.method}");

    if (e.response != null) {
      log("StatusCode : ${e.response?.statusCode}");
      log("Response   : ${e.response?.data}");
    } else {
      log("No response received from server.");
    }

    log("------------------------");
  }

  /// Force logout (hapus cookie + arahkan ke login)
  Future<void> _forceLogout() async {
    // _refreshTimer?.cancel();
    await cookieJar.deleteAll();

    Get.offAllNamed('/login-customer');
  }

  // =====================================================
  // ================= AUTH ==============================
  // =====================================================

  Future<Map<String, dynamic>> login(String email, String password) async {
    log("start process login");
    try {
      log("Attempting login for $email");
      final response = await dio.post(
        "/api/ecommerce/auth/_login",
        data: {"email": email, "password": password},
      );
      log("respon login: $response");

      if (response.statusCode == 200) {
        if (kDebugMode) print("✅ Login berhasil: ${response.data}");
        return Map<String, dynamic>.from(response.data);
      } else {
        log("gagal login ${response.statusCode}");
        throw ApiException(response.data);
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      log("error login: $e");
      throw ApiException(msg);
      // throw ApiException("Gagal login: $msg");
    } catch (e) {
      throw ApiException("Kesalahan tidak diketahui: $e");
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String role,
      required String namaDepan,
      required String namaBelakang,
      required String noWa,
      required String alamat,
      required String daerahId,
      required String wilayahId,
      String? namaAgen,
      String? alamatAgen,
      String? namaDistributor,
      String? alamatDistributor,
      String? latitude,
      String? longitude}) async {
    print("api hit");
    final payload = {
      "email": email,
      "password": password,
      "role": role,
      "data_user": {
        "nama_depan": namaDepan,
        "nama_belakang": namaBelakang,
        "no_wa": noWa,
        "alamat": alamat,
        "daerah_id": daerahId,
        "wilayah_id": wilayahId,
        "latitude": latitude,
        "longitude": longitude,
      },
      "agent": {
        "nama_agen": namaAgen,
        "alamat_agen": alamatAgen,
      },
      "distributor": {
        "nama_distributor": namaDistributor,
        "alamat_distributor": alamatDistributor,
      }
    };

    try {
      final response =
          await dio.post("/api/ecommerce/auth/_register", data: payload);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Registrasi berhasil");
      }
    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message'] ?? e.message;
      throw ApiException("$serverMessage");
    } catch (e) {
      throw ApiException("Error tidak di ketahui ${e.toString()}");
    }
  }

  Future<void> logout() async {
    try {
      final response =
          await dio.delete("/api/ecommerce/auth/_logout"); // pakai interceptor
      if (response.statusCode == 200) {
        // _refreshTimer?.cancel();
        await cookieJar.deleteAll();
        if (kDebugMode) print("✅ Logout berhasil");
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      throw ApiException("$msg");
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      final response = await dio.get("/api/ecommerce/auth/_user-auth");
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw ApiException("Gagal ambil data pengguna");
      }
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      throw ApiException("$msg");
    }
  }

  // =====================================================
  // ================= TOKEN MANAGEMENT ==================
  // =====================================================

  Future<bool> isTokenExpired() async {
    log("Checking if token is expired...");
    final cookies = await cookieJar.loadForRequest(Uri.parse(baseUrl!));
    final token = cookies.firstWhere(
      (c) => c.name == "TOKEN",
      orElse: () => Cookie("TOKEN", ""),
    );

    if (token.value.isEmpty) return true;
    if (token.expires == null) return true;

    return DateTime.now().isAfter(token.expires!);
  }

  Future<bool> isRefreshTokenExpired() async {
    log("Checking if refresh token is expired...");
    final cookies = await cookieJar.loadForRequest(Uri.parse(baseUrl!));
    final refresh = cookies.firstWhere(
      (c) => c.name == "TOKEN-REFRESH",
      orElse: () => Cookie("TOKEN-REFRESH", ""),
    );

    if (refresh.value.isEmpty) return true;
    if (refresh.expires == null) return true;

    return DateTime.now().isAfter(refresh.expires!);
  }

  Future<bool> refreshToken() async {
    log("Attempting to refresh token...");
    log("token-refresh: ${cookieJar.storage}");
    try {
      final response = await dio.post("/api/ecommerce/auth/_refresh-token");
      if (response.statusCode == 200) {
        // simpan token baru ke cookieJar/secure storage
        log("Token berhasil direfresh");
        return true;
      }
    } catch (e) {
      log("Refresh token gagal: $e");
    }
    return false;
  }

  // Future<bool> refreshToken() async {
  //   log("Attempting to refresh token...");

  //   try {
  //     final response = await dio.post(
  //       "/api/ecommerce/auth/_refresh-token",
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           // Don't include Authorization header for refresh request
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       log("Token berhasil direfresh");
  //       return true;
  //     } else {
  //       log("Refresh token failed with status: ${response.statusCode}");
  //       return false;
  //     }
  //   } on DioException catch (e) {
  //     log("Refresh token gagal: ${e.message}");
  //     if (e.response?.statusCode == 401) {
  //       // Refresh token itself is invalid
  //       await _forceLogout();
  //     }
  //     return false;
  //   } catch (e) {
  //     log("Unexpected error during token refresh: $e");
  //     return false;
  //   }
  // }

  // =====================================================
  // ================= ALAMAT ============================
  // =====================================================

  Future<Map<String, dynamic>> createAlamat(AlamatInputUpdate alamat) async {
    final payload = {
      "label": alamat.label,
      "detail": alamat.detail,
      "is_default": alamat.isDefault,
      "wilayah_id": alamat.wilayahId,
      "daerah_id": alamat.daerahId,
      "longitude": alamat.longitude,
      "latitude": alamat.latitude,
    };
    final response =
        await dio.post("/api/ecommerce/auth/alamat", data: payload);
    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> updateAlamat(
      String alamatId, AlamatInputUpdate alamat) async {
    final payload = {
      "label": alamat.label,
      "detail": alamat.detail,
      "is_default": alamat.isDefault,
      "wilayah_id": alamat.wilayahId,
      "daerah_id": alamat.daerahId,
      "longitude": alamat.longitude,
      "latitude": alamat.latitude,
    };
    final response =
        await dio.put("/api/ecommerce/auth/alamat/$alamatId", data: payload);
    return Map<String, dynamic>.from(response.data);
  }

  Future<void> deleteAlamat(String alamatId) async {
    await dio.delete("/api/ecommerce/auth/alamat/$alamatId");
  }
}

/// Exception khusus API
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
