import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'package:lpkni/app/data/Customer/Model/cart_model.dart' hide Produk;
import 'package:lpkni/app/data/Customer/Model/checkout_model.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';
import 'package:lpkni/app/data/Customer/Model/order_model.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:lpkni/app/services/auth_service.dart';

class ApiService {
  // static const String baseUrl = "https://dev.pollacheialnetworks.my.id";
  final AuthService authService;
  Dio get dio => authService.dio;

  ApiService(this.authService);

  /// Produk penjualan (pakai http biasa karena parsing di isolate)
  Future<List<Produk>> getProducts({int page = 1, int limit = 4}) async {
    // final response = await http.get(Uri.parse("$baseUrl/api/produk/penjualan"));
    final response = await dio.get("/api/produk/penjualan",
        queryParameters: {"page": page, "limit": limit});
    // log("response produk: $response");

    if (response.statusCode == 200) {
      return compute(parseProduk, jsonEncode(response.data));
      // return compute(parseProduk, response.body);
    } else {
      throw ApiException("Gagal ambil data produk (${response.statusCode})");
    }
  }

  /// Berita / Artikel
  Future<ArtikelResponse> getNews() async {
    try {
      final response = await dio.get("/api/berita-content");
      if (response.statusCode == 200) {
        return ArtikelResponse.fromJson(response.data);
      } else {
        throw ApiException("Gagal mendapatkan berita: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw ApiException(
          "Gagal mendapatkan data berita: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  /// Cart
  Future<CartResponse> getItemCart() async {
    try {
      final response = await dio.get("/api/ecommerce/cart");
      if (response.statusCode == 200) {
        return CartResponse.fromJson(response.data);
      }
      throw ApiException(
          "Kesalahan saat fetch data cart: ${response.statusMessage}");
    } on DioException catch (e) {
      throw ApiException(
          "Gagal mendapatkan data keranjang: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  Future<Map<String, dynamic>> addToCart(
      String productId, String gudangId, int quantity) async {
    try {
      final response = await dio.post(
        "/api/ecommerce/cart",
        data: {
          "produk_id": productId,
          "gudang_id": gudangId,
          "quantity": quantity,
        },
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw ApiException(
          "Gagal menambahkan produk ke keranjang: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  Future<void> removeFromCart(String productID) async {
    try {
      final response = await dio.delete("/api/ecommerce/cart/item/$productID");
      if (response.statusCode != 200) {
        throw ApiException("Gagal menghapus item: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw ApiException(
          "Gagal menghapus produk dari keranjang: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  Future<Map<String, dynamic>> updateQty(String productId, int quantity) async {
    log("produk id: $productId, quantity: $quantity");
    try {
      final response = await dio.put(
        "/api/ecommerce/cart/item/$productId",
        data: {"quantity": quantity},
      );
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw ApiException(
          "Gagal merubah quantity: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  /// Wilayah & Daerah
  Future<Map<String, dynamic>> getWilayah() async {
    try {
      final response = await dio.get("/api/wilayah");
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw ApiException(
          "Gagal mendapatkan wilayah: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  Future<Map<String, dynamic>> getDaerahByWilayah(String idWilayah) async {
    try {
      final response = await dio.get("/api/daerah/wilayah/$idWilayah");
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw ApiException(
          "Gagal mendapatkan daerah: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  /// Checkout
  Future<Response> checkOut(List<Checkout> cos) async {
    final payload = cos.map((e) => e.toJson()).toList();
    try {
      final response = await dio.post("/api/ecommerce/checkout", data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      }
      throw ApiException("Gagal melakukan checkout: ${response.statusMessage}");
    } on DioException catch (e) {
      throw ApiException(
          "Gagal melakukan checkout: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  Future<CheckoutResponse> getCheckout() async {
    try {
      final response = await dio.get("/api/ecommerce/checkout");
      final decoded =
          response.data is String ? jsonDecode(response.data) : response.data;
      return CheckoutResponse.fromJson(decoded);
    } on DioException catch (e) {
      throw ApiException(
          "Gagal mendapatkan data checkout: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  /// Membuat order baru
  Future<Map<String, dynamic>> createOrder(Order order) async {
    final payload = order.toJson();
    log("createOrder payload: ${jsonEncode(payload)}");

    try {
      final response = await dio.post(
        "/api/ecommerce/_orders",
        data: payload, // langsung Map, bukan List
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw ApiException("Gagal membuat order: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw ApiException(
        "Gagal membuat order: ${e.response?.data?['message'] ?? e.message}",
      );
    } catch(e) {
      throw ApiException("Kesalahan sistem: $e");
    }
  }

  Future<Map<String, dynamic>> getMethodPayment() async {
    try {
      final response = await dio.get("/api/ecommerce/metode-pembayaran/aktif");
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw ApiException(
          "Gagal mendapatkan metode pembayaran: ${e.response?.data?['message'] ?? e.message}");
    }
  }

  Future<Map<String, dynamic>> getOrderHistory() async {
    try {
      final response = await dio.get("/api/ecommerce/_orders/auth");
      log("respon apiService: ${response.data}");
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      throw ApiException(
          "gagal mengambil data riwayat pesanan: ${e.response?.data['message'] ?? e.message}");
    }
  }

  Future<void> compliteOrder(String id, String status) async{
    try{
      final payload =  {"status": status};
      final respone = await dio.put("/api/ecommerce/_orders/status/$id",data: payload);
      if ( respone.statusCode == 200) {
        return respone.data;
      }
    } on DioException catch(e){
      log("Gagal menyelesaikan pesanan: ${e.response?.data['message'] ?? e.message}");
      throw ApiException("Gagal menyelesaikan pesanan: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      log("error sistem tidak di ketahui $e");
      throw ApiException("error sistem tidak di ketahui $e");
    }
  }
}

/// Parsing Produk (jalan di isolate)
List<Produk> parseProduk(String responseBody) {
  final decoded = json.decode(responseBody);
  final List jsonResponse = decoded['data'];
  return jsonResponse.map((item) => Produk.fromJson(item)).toList();
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message) {
    log("ApiException: $message");
  }

  @override
  String toString() => message;
}
