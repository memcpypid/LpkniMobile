import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Menu/Controllers/CustomerMenu_controller.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/views/MenuDetailCustomer_view.dart';

class CustomermenuView extends StatelessWidget {
  final CustomermenuController menuController =
      Get.find<CustomermenuController>();
  final ButtomnavbarController navbarController =
      Get.find<ButtomnavbarController>();
  final CartcustomerController cartController =
      Get.find<CartcustomerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 10),
            _buildMenuGrid(), // ✅ Pakai Expanded agar bisa scroll
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: navbarController),
    );
  }

  // ✅ Fungsi Refresh (Tarik ke Bawah untuk Reload Data)
  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi loading
    menuController.loadMenu(); // Ambil ulang data dari controller
  }

  // AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      // leading: IconButton(
      //   icon: const Icon(Icons.arrow_back, color: Colors.black),
      //   onPressed: () => Get.back(),
      // ),
      title: const Text(
        "Specials For You",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  // Search Bar
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.black54),
        hintText: "Search",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.green),
        ),
        // suffixIcon: const Icon(Icons.tune, color: Colors.green),
      ),
    );
  }

  // ✅ Grid untuk menampilkan menu (bisa di-scroll)
  Widget _buildMenuGrid() {
    return Expanded(
      // ✅ Pastikan GridView bisa mengambil sisa ruang
      child: Obx(() {
        if (menuController.foodItems.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Tidak ada produk terlaris",
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          physics: const AlwaysScrollableScrollPhysics(), // ✅ Bisa di-scroll
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.5,
          ),
          itemCount: menuController.foodItems.length,
          itemBuilder: (context, index) {
            final product = menuController.foodItems[index];
            return _buildProductItem(product);
          },
        );
      }),
    );
  }

  // Widget kartu makanan
  Widget _buildProductItem(FoodItem product, {bool isHorizontal = false}) {
    final CartcustomerController cartController =
        Get.find<CartcustomerController>(); // ✅ Ambil CartController

    return SizedBox(
      width: isHorizontal ? 170 : null,
      child: GestureDetector(
        onTap: () {
          Get.to(() => MenudetailcustomerView(
              foodItem: product)); // 🔥 Navigasi ke Menu Detail
        },
        child: Card(
          elevation: 4,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  product.image,
                  width: double.infinity,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),

              // Isi Produk (Nama, Rating, Harga, Deskripsi)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama Produk
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // ⭐ Rating Produk
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: product.rating,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 16,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Harga Produk
                      Row(
                        children: [
                          const Icon(Icons.local_offer,
                              color: Colors.green, size: 15),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              product.price,
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),

                      // Deskripsi Produk (Tidak Terpotong)
                      Flexible(
                        child: Text(
                          product.Desc,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black26,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              ),

              // **Baris Bawah: Terjual & Tombol Keranjang**
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Jumlah Terjual di Kiri
                    Text(
                      '${product.soldCount} Terjual',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                        fontSize: 13,
                      ),
                    ),

                    // Tombol Keranjang di Kanan
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined,
                            color: Colors.orange),
                        onPressed: () {
                          cartController
                              .addToCart(product); // ✅ Tambahkan ke keranjang
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
