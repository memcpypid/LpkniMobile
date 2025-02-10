import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';
import 'package:lpkni/app/modules/Customer/CartCustomer/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/food_controller.dart';

import 'package:lpkni/app/modules/Customer/Home/controllers/news_controller.dart';
import 'package:badges/badges.dart' as badges; // Tambahkan ini di atas

class HomecustomerView extends StatelessWidget {
  HomecustomerView({super.key});

  final FoodController productController = Get.find<FoodController>();
  final NewsController newsController = Get.find<NewsController>();
  final ButtomnavbarController navbarController =
      Get.find<ButtomnavbarController>();
  final CartcustomerController cartController =
      Get.find<CartcustomerController>();
  Future<void> _refreshData() async {
    // Simulasi delay saat mengambil data
    await Future.delayed(const Duration(seconds: 2));

    // Panggil ulang data dari controller atau API
    productController.loadProducts(); // Jika menggunakan controller
    newsController.loadNews(); // Jika ada berita
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBarWithSearch(context, 3, 5),
      body: RefreshIndicator(
        onRefresh: _refreshData, // Fungsi untuk refresh
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // Pastikan selalu bisa scroll
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(
                    "Baru Hari Ini", 'Makanan baru hari ini', () {}),
                _buildHorizontalProductList(),
                _buildSectionTitle("Berita", 'Berita Baru Hari ini', () {}),
                _buildHorizontalNewsList(),
                _buildSectionTitle(
                    "Penjualan Terbaik", 'Daftar Makanan Terlaris', () {}),
                _buildVerticalBestSellerGrid(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: navbarController),
    );
  }

  PreferredSize _buildAppBarWithSearch(
      BuildContext context, int notifCount, int messageCount) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80), // Sesuaikan tinggi AppBar
      child: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        flexibleSpace: Padding(
          padding:
              const EdgeInsets.only(top: 40.0, left: 16, right: 16, bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo di ujung kiri
              Image.asset(
                'assets/images/logo.png',
                height: 40,
              ),
              const SizedBox(width: 10),
              // Search Bar (Menggunakan Expanded agar responsif)
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Cari produk...",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    // suffixIcon: const Icon(Icons.tune),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Notifikasi (Dengan Badge)
              badges.Badge(
                badgeContent: Text(
                  notifCount > 9
                      ? "9+"
                      : notifCount.toString(), // Jika > 9, tampilkan "9+"
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                showBadge: notifCount > 0, // Hanya tampil jika ada notifikasi
                position: badges.BadgePosition.topEnd(top: 0, end: 0),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 5),

              // Pesan (Dengan Badge)
              badges.Badge(
                badgeContent: Text(
                  messageCount > 9
                      ? "9+"
                      : messageCount.toString(), // Jika > 9, tampilkan "9+"
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                showBadge: messageCount > 0, // Hanya tampil jika ada pesan
                position: badges.BadgePosition.topEnd(top: 0, end: 0),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                child: IconButton(
                  icon: const Icon(Icons.chat_bubble, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4), // Beri jarak antara title dan subtitle
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey), // Subtitle dengan warna abu-abu
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: const Text("Semua >", style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalProductList() {
    return Obx(() {
      if (productController.newProducts.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child:
                Text("Belum ada produk baru", style: TextStyle(fontSize: 16)),
          ),
        );
      }
      return SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: productController.newProducts.length,
          itemBuilder: (context, index) {
            final product = productController.newProducts[index];
            return _buildProductItemHorizontal(product, isHorizontal: true);
          },
        ),
      );
    });
  }

  Widget _buildHorizontalNewsList() {
    return Obx(() {
      if (newsController.newsList.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text("Tidak ada berita saat ini",
                style: TextStyle(fontSize: 16)),
          ),
        );
      }
      return SizedBox(
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: newsController.newsList.length,
          itemBuilder: (context, index) {
            final news = newsController.newsList[index];
            return _buildNewsItem(news);
          },
        ),
      );
    });
  }

  Widget _buildVerticalBestSellerGrid() {
    return Obx(() {
      if (productController.bestSellers.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Text("Tidak ada produk terlaris",
                style: TextStyle(fontSize: 16)),
          ),
        );
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.45,
        ),
        itemCount: productController.bestSellers.length,
        itemBuilder: (context, index) {
          final product = productController.bestSellers[index];
          return _buildProductItem(product);
        },
      );
    });
  }

  Widget _buildProductItem(FoodItem product, {bool isHorizontal = false}) {
    return SizedBox(
      width: isHorizontal ? 170 : null,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

            // Isi Produk (Teks + Rating + Harga + Deskripsi)
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

                    // ⭐ Rating
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
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Membuat Terjual di kiri, Keranjang di kanan
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

                  // Tombol Shopping Cart di Kanan
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
                      onPressed: () => cartController.addToCart(product),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItemHorizontal(FoodItem product,
      {bool isHorizontal = false}) {
    return SizedBox(
      width: isHorizontal ? 170 : null,
      child: Card(
        elevation: 4,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    product.image,
                    width: double.infinity,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.local_offer,
                          color: Colors.green, size: 15),
                      const SizedBox(width: 4),
                      Text(
                        product.price,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 13),
                      ),
                    ],
                  ),
                  Text(
                    product.Desc,
                    textAlign: TextAlign.center,
                    maxLines: 1, // Batasi menjadi 2 baris
                    overflow: TextOverflow
                        .ellipsis, // Tambahkan ... jika teks terlalu panjang
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    '${product.soldCount} Terjual',
                    textAlign: TextAlign.center,
                    maxLines: 1, // Batasi menjadi 2 baris
                    overflow: TextOverflow
                        .ellipsis, // Tambahkan ... jika teks terlalu panjang
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      fontSize: 13,
                    ),
                  ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildNewsItem(News news) {
  return Container(
    width: 300, // Lebar tiap berita
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(news.image,
              fit: BoxFit.cover, width: double.infinity, height: 180),
        ),
        Positioned(
          left: 16,
          bottom: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                news.description,
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Lihat >"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
