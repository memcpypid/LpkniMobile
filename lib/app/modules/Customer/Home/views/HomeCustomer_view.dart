import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Home/Model/food_model.dart';
import 'package:lpkni/app/modules/Customer/Home/Model/news_model.dart';
import 'package:lpkni/app/modules/Customer/CartCustomer/controllers/cart_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/food_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/news_controller.dart';

class HomecustomerView extends StatelessWidget {
  HomecustomerView({super.key});

  final FoodController productController = Get.find<FoodController>();
  final NewsController newsController = Get.find<NewsController>();
  final ButtomnavbarController navbarController =
      Get.find<ButtomnavbarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              _buildSectionTitle("Baru Hari Ini", () {}),
              _buildHorizontalProductList(),
              _buildSectionTitle("Berita", () {}),
              _buildHorizontalNewsList(),
              _buildSectionTitle("Penjualan Terbaik", () {}),
              _buildVerticalBestSellerGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: navbarController),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.teal,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {},
      ),
      title: Image.asset(
        'assets/images/logo.png',
        height: 40,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Cari",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: const Icon(Icons.tune),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          GestureDetector(
            onTap: onTap,
            child: const Text("Semua", style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalProductList() {
    return Obx(() => SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productController.newProducts.length,
            itemBuilder: (context, index) {
              final product = productController.newProducts[index];
              return _buildProductItem(product, isHorizontal: true);
            },
          ),
        ));
  }

  Widget _buildHorizontalNewsList() {
    return Obx(() => SizedBox(
          height: 180, // Tinggi card berita
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: newsController.newsList.length,
            itemBuilder: (context, index) {
              final news = newsController.newsList[index];
              return _buildNewsItem(news);
            },
          ),
        ));
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
                  child: const Text("Lihat"),
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

  Widget _buildVerticalBestSellerGrid() {
    return Obx(() => GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: productController.bestSellers.length,
          itemBuilder: (context, index) {
            final product = productController.bestSellers[index];
            return _buildProductItem(product);
          },
        ));
  }

  Widget _buildProductItem(FoodItem product, {bool isHorizontal = false}) {
    final CartController cartController = Get.find<CartController>();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(product.image,
                    width: double.infinity, height: 100, fit: BoxFit.cover),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () => cartController.addToCart(product),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 25,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(product.price,
                    style: const TextStyle(color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
