import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/AddToCartBottomSheet_widget.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/successDialog_widget.dart';
import 'package:lpkni/app/modules/Customer/Home/controllers/HomeCustomer_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:lpkni/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class HomecustomerView extends StatelessWidget {
  HomecustomerView({super.key});

  final HomecustomerController controller = Get.find<HomecustomerController>();
  final ButtomnavbarController navbarController = Get.find<ButtomnavbarController>();
  final CartcustomerController cartController = Get.find<CartcustomerController>();

  final baseUrl = dotenv.env['BASE_URL'];

  // Enhanced color palette
  final Color primaryBlue = const Color(0xFF2196F3);
  final Color lightBlue = const Color(0xFFE3F2FD);
  final Color darkBlue = const Color(0xFF1976D2);
  final Color accentBlue = const Color(0xFF0D47A1);
  final Color successGreen = const Color(0xFF4CAF50);
  final Color backgroundGray = const Color(0xFFF5F7FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            _buildSliverAppBar(context, 3, 5, 1, innerBoxIsScrolled),
          ];
        },
        body: RefreshIndicator(
          onRefresh: controller.refreshData,
          color: primaryBlue,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _buildWelcomeSection(),
                _buildMainContent(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: navbarController),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context, int notifCount, 
      int messageCount, int transaction, bool isScrolled) {
    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBlue, darkBlue],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                children: [
                  _buildTopBar(notifCount),
                  const SizedBox(height: 10),
                  _buildSearchBar(),
                  // const SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: Container(
          height: 20,
          decoration: const BoxDecoration(
            color: Color(0xFFF5F7FA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(int notifCount) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            'assets/images/qmas-logo.png',
            height: 24,
          ),
        ),
        const Spacer(),
        _buildModernActionButton(
          Icons.notifications_rounded,
          notifCount,
          () => Get.toNamed(Routes.NOTIFICATIONCUSTOMER),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: primaryBlue, size: 22),
          hintText: "Cari produk Q-Mas M...",
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildModernActionButton(IconData icon, int count, VoidCallback onPressed) {
    return badges.Badge(
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
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white, size: 20),
          onPressed: onPressed,
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            lightBlue.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [primaryBlue, darkBlue]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.water_drop, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang di Q-Mas Store",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Air murni berkualitas untuk hidup sehat Anda",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildModernSectionHeader(
            "💧 Produk Terbaru",
            "Air segar hari ini",
            () => print('Semua Produk'),
          ),
          const SizedBox(height: 16),
          _buildHorizontalProductList(),
          const SizedBox(height: 32),
          _buildModernSectionHeader(
            "📰 Berita Terkini",
            "Update terbaru seputar Q-Mas M",
            () {},
          ),
          const SizedBox(height: 16),
          _buildHorizontalNewsList(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildModernSectionHeader(String title, String subtitle, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: 4),
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
      ],
    );
  }

  Widget _buildHorizontalProductList() {
    return Obx(() {
      if (controller.newProducts.isEmpty) {
        return _buildEmptyState("Belum ada produk baru", Icons.water_drop_outlined);
        return _buildEmptyState("Belum ada produk baru", Icons.water_drop_outlined);
      }
      return SizedBox(
        height: 320,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          itemCount: controller.newProducts.length,
          itemBuilder: (context, index) {
            final product = controller.newProducts[index];
            return _buildModernProductCard(product, isHorizontal: true);
            return _buildModernProductCard(product, isHorizontal: true);
          },
        ),
      );
    });
  }

  Widget _buildHorizontalNewsList() {
    return Obx(() {
      if (controller.artikelList.isEmpty) {
        return _buildEmptyState("Tidak ada berita saat ini", Icons.newspaper);
      }
      return SizedBox(
        height: 220,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          itemCount: controller.artikelList.length,
          itemBuilder: (context, index) {
            final news = controller.artikelList[index];
            return _buildModernNewsCard(news, baseUrl!);
          },
        ),
      );
    });
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(icon, size: 30, color: Colors.grey[400]),
            ),
            const SizedBox(height: 12),
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

  Widget _buildModernProductCard(Produk product, {bool isHorizontal = false}) {
    final imageUrl = product.fotoProduk.isNotEmpty ? product.fotoProduk.first.url : null;

    return Container(
      width: isHorizontal ? 200 : null,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.MENUDETAILCUSTOMER, arguments: product),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: imageUrl != null
                        ? Image.network(
                            "$baseUrl$imageUrl",
                            width: double.infinity,
                            height: isHorizontal ? 140 : 180,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: isHorizontal ? 140 : 180,
                            color: Colors.grey[200],
                            child: Icon(Icons.image_not_supported, 
                                size: 40, color: Colors.grey[400]),
                          ),
                  ),
                  
                  // Stock Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: product.stokAkhirBaik > 10 
                            ? successGreen 
                            : product.stokAkhirBaik > 0 
                                ? Colors.orange 
                                : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "${product.stokAkhirBaik} stok",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Product Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.nama} ${product.kategori} ${product.kemasan}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: darkBlue,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),

                      if (!isHorizontal && product.deskripsi != null)
                        Expanded(
                          child: Text(
                            product.deskripsi!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                              height: 1.3,
                            ),
                          ),
                        ),

                      const Spacer(),

                      // Bottom Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: lightBlue.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${product.jmlPenjualan} terjual',
                              style: TextStyle(
                                color: accentBlue,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [primaryBlue, darkBlue]),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryBlue.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: product.stokAkhirBaik > 0
                                  ? () => _showAddToCartBottomSheet(product)
                                  : null,
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

  Widget _buildModernNewsCard(ArtikelModel news, String baseUrl) {
    return Container(
      width: 340,
      margin: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () async {
          final url = "$baseUrl/artikel-qmasm/detail/${news.slug}";
          final uri = Uri.parse(url);

          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            await launchUrl(uri, mode: LaunchMode.platformDefault);
            Get.snackbar("Kesalahan", "Tidak bisa menemukan berita");
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: news.media.isNotEmpty
                    ? Image.network(
                        "$baseUrl${news.media.first.imageUrl}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 220,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(
                              width: double.infinity,
                              height: 220,
                              color: Colors.grey[300],
                              child: const Icon(Icons.broken_image, size: 50),
                            ),
                      )
                    : Container(
                        width: double.infinity,
                        height: 220,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      ),
              ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),

              // Content
              Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.judul.length > 35
                          ? "${news.judul.substring(0, 35)}..."
                          : news.judul,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news.deskripsi1.length > 60
                          ? "${news.deskripsi1.substring(0, 60)}..."
                          : news.deskripsi1,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

  void _showAddToCartBottomSheet(Produk product) async {
    final quantity = await Get.bottomSheet<int>(
      AddToCartBottomSheet(
        product: product,
        baseUrl: baseUrl!,
        primaryBlue: primaryBlue,
        darkBlue: darkBlue,
        lightBlue: lightBlue,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    if (quantity != null && cartController.isSuccess.value == true) {
      _showSuccessDialog(product, quantity);
    }
  }

  void _showSuccessDialog(Produk product, int quantity) {
    Get.dialog(
      SuccessDialog(
        product: product,
        quantity: quantity,
        primaryBlue: primaryBlue,
        successGreen: successGreen,
        darkBlue: darkBlue,
      ),
    );
  }
}