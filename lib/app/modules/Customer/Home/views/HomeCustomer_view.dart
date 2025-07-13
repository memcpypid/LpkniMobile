import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/HomeCustomer_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:lpkni/app/routes/app_pages.dart';

class HomecustomerView extends StatelessWidget {
  HomecustomerView({super.key});

  final HomecustomerController controller = Get.find<HomecustomerController>();
  final ButtomnavbarController navbarController = Get.find<ButtomnavbarController>();
  final CartcustomerController cartController = Get.find<CartcustomerController>();

  // Warna tema air mineral
  final Color primaryBlue = Color(0xFF86AEFF);
  final Color lightBlue = Color(0xFFB3D9FF);
  final Color darkBlue = Color(0xFF4A90E2);
  final Color accentBlue = Color(0xFF1E56A0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFF), // Background biru sangat muda
      appBar: _buildModernAppBar(context, 3, 5, 1),
      body: RefreshIndicator(
        onRefresh: controller.refreshData,
        color: primaryBlue,
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Header dengan gradient
              _buildWelcomeHeader(),

              // Konten utama
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildModernSectionTitle(
                      "💧 Produk Terbaru",
                      'Air mineral segar hari ini',
                          () => print('semua Produk Baru'),
                    ),
                    const SizedBox(height: 12),
                    _buildHorizontalProductList(),

                    const SizedBox(height: 24),
                    _buildModernSectionTitle(
                      "📰 Berita Terkini",
                      'Update terbaru seputar kesehatan',
                          () {},
                    ),
                    const SizedBox(height: 12),
                    _buildHorizontalNewsList(),

                    const SizedBox(height: 24),
                    _buildModernSectionTitle(
                      "🏆 Terlaris",
                      'Pilihan favorit pelanggan',
                          () {},
                    ),
                    const SizedBox(height: 12),
                    _buildVerticalBestSellerGrid(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: navbarController),
    );
  }

  PreferredSize _buildModernAppBar(BuildContext context, int notifCount, int messageCount, int transaction) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBlue,
              darkBlue,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 16, right: 16, bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo dengan efek
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    'assets/images/qmas-logo.png',
                    height: 22,
                  ),
                ),
                const SizedBox(width: 10),

                // Search Bar Modern
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search, color: primaryBlue),
                        hintText: "Cari air mineral...",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Action Buttons dengan badge modern
                _buildModernActionButton(
                  Icons.history_rounded,
                  transaction,
                      () => Get.toNamed(Routes.CHATLISTCUSTOMER),
                ),
                _buildModernActionButton(
                  Icons.chat_bubble_rounded,
                  messageCount,
                      () => Get.toNamed(Routes.CHATLISTCUSTOMER),
                ),
                _buildModernActionButton(
                  Icons.notifications_rounded,
                  notifCount,
                      () => Get.toNamed(Routes.NOTIFICATIONCUSTOMER),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernActionButton(IconData icon, int count, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.only(left: 4),
      child: badges.Badge(
        badgeContent: Text(
          count > 9 ? "9+" : count.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        showBadge: count > 0,
        position: badges.BadgePosition.topEnd(top: -2, end: -2),
        badgeStyle: badges.BadgeStyle(
          badgeColor: Colors.red[400]!,
          elevation: 2,
        ),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 20),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            primaryBlue.withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.water_drop, color: primaryBlue, size: 24),
                SizedBox(width: 8),
                Text(
                  "Selamat datang di QMas Water",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Air mineral berkualitas untuk hidup sehat Anda",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernSectionTitle(String title, String subtitle, VoidCallback onTap) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryBlue.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Lihat Semua",
                    style: TextStyle(
                      color: accentBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, color: accentBlue, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalProductList() {
    return Obx(() {
      if (controller.newProducts.isEmpty) {
        return _buildEmptyState("Belum ada produk baru", Icons.water_drop_outlined);
      }
      return SizedBox(
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 4),
          itemCount: controller.newProducts.length,
          itemBuilder: (context, index) {
            final product = controller.newProducts[index];
            return _buildModernProductCard(product, isHorizontal: true);
          },
        ),
      );
    });
  }

  Widget _buildHorizontalNewsList() {
    return Obx(() {
      if (controller.newsList.isEmpty) {
        return _buildEmptyState("Tidak ada berita saat ini", Icons.newspaper);
      }
      return SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 4),
          itemCount: controller.newsList.length,
          itemBuilder: (context, index) {
            final news = controller.newsList[index];
            return _buildModernNewsCard(news);
          },
        ),
      );
    });
  }

  Widget _buildVerticalBestSellerGrid() {
    return Obx(() {
      if (controller.bestSellers.isEmpty) {
        return _buildEmptyState("Tidak ada produk terlaris", Icons.trending_up);
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.48,
        ),
        itemCount: controller.bestSellers.length,
        itemBuilder: (context, index) {
          final product = controller.bestSellers[index];
          return _buildModernProductCard(product);
        },
      );
    });
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.grey[400]),
            SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernProductCard(FoodItem product, {bool isHorizontal = false}) {
    return Container(
      width: isHorizontal ? 180 : null,
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.MENUDETAILCUSTOMER, arguments: product),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: primaryBlue.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar dengan overlay gradient
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      product.image,
                      width: double.infinity,
                      height: isHorizontal ? 120 : 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Gradient overlay
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryBlue, darkBlue],
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 14),
                          SizedBox(width: 2),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Konten produk
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama produk
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: darkBlue,
                        ),
                      ),
                      SizedBox(height: 6),

                      // Harga dengan styling modern
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: lightBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          product.price,
                          style: TextStyle(
                            color: accentBlue,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 6),

                      // Deskripsi
                      if (!isHorizontal)
                        Expanded(
                          child: Text(
                            product.Desc,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ),

                      // Bottom section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.soldCount} terjual',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryBlue, darkBlue],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryBlue.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: () => cartController.addToCart(product),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernNewsCard(News news) {
    return Container(
      width: 320,
      margin: EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.NEWSDETAILCUSTOMER, arguments: news),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  news.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Content
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title.length > 30 ? "${news.title.substring(0, 30)}..." : news.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      news.description.length > 50 ? "${news.description.substring(0, 50)}..." : news.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Baca Selengkapnya",
                        style: TextStyle(
                          color: accentBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
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