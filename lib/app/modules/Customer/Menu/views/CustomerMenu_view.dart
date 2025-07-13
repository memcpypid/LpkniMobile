import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Menu/Controllers/CustomerMenu_controller.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class CustomermenuView extends StatelessWidget {
  final CustomermenuController menuController = Get.find<CustomermenuController>();
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
      backgroundColor: Color(0xFFF8FBFF),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: primaryBlue,
        backgroundColor: Colors.white,
        child: CustomScrollView(
          slivers: [
            _buildModernSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSearchAndFilter(),
                  // SizedBox(height: 16), // Dihapus karena kategori tidak ada
                ],
              ),
            ),
            _buildProductGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(controller: navbarController),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    menuController.loadMenu();
  }

  Widget _buildModernSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryBlue,
              darkBlue,
            ],
          ),
        ),
        child: FlexibleSpaceBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.water_drop, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  "Premium Water Collection",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryBlue,
                  darkBlue,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Floating water drops decoration
                ...List.generate(6, (index) => _buildFloatingWaterDrop(index)),
              ],
            ),
          ),
        ),
      ),
      leading: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
    );
  }

  Widget _buildFloatingWaterDrop(int index) {
    final positions = [
      {'top': 20.0, 'left': 30.0},
      {'top': 60.0, 'right': 40.0},
      {'top': 40.0, 'left': 100.0},
      {'top': 80.0, 'right': 80.0},
      {'top': 30.0, 'right': 120.0},
      {'top': 70.0, 'left': 200.0},
    ];

    return Positioned(
      top: positions[index]['top'],
      left: positions[index]['left'],
      right: positions[index]['right'],
      child: Icon(
        Icons.water_drop,
        color: Colors.white.withOpacity(0.1),
        size: 16 + (index * 2),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: primaryBlue),
                  hintText: "Cari air mineral favorit...",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryBlue, darkBlue],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: primaryBlue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.tune, color: Colors.white),
              onPressed: () {
                // Filter functionality
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildCategoryTabs() { // Dihapus karena tidak diperlukan
  //   final categories = [
  //     {'name': 'Semua', 'icon': Icons.water_drop},
  //     {'name': 'Premium', 'icon': Icons.diamond},
  //     {'name': 'Regular', 'icon': Icons.local_drink},
  //     {'name': 'Gallon', 'icon': Icons.water_drop_outlined},
  //   ];

  //   return Container(
  //     height: 60,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       padding: EdgeInsets.symmetric(horizontal: 16),
  //       itemCount: categories.length,
  //       itemBuilder: (context, index) {
  //         final category = categories[index];
  //         final isSelected = index == 0; // Default first selected

  //         return Container(
  //           margin: EdgeInsets.only(right: 12),
  //           child: GestureDetector(
  //             onTap: () {
  //               // Category selection logic
  //             },
  //             child: Container(
  //               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //               decoration: BoxDecoration(
  //                 gradient: isSelected
  //                   ? LinearGradient(colors: [primaryBlue, darkBlue])
  //                   : null,
  //                 color: isSelected ? null : Colors.white,
  //                 borderRadius: BorderRadius.circular(25),
  //                 border: Border.all(
  //                   color: isSelected ? Colors.transparent : primaryBlue.withOpacity(0.3),
  //                 ),
  //                 boxShadow: [
  //                   BoxShadow(
  //                     color: isSelected
  //                       ? primaryBlue.withOpacity(0.3)
  //                       : Colors.grey.withOpacity(0.1),
  //                     blurRadius: 8,
  //                     offset: Offset(0, 2),
  //                   ),
  //                 ],
  //               ),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Icon(
  //                     category['icon'] as IconData,
  //                     color: isSelected ? Colors.white : primaryBlue,
  //                     size: 18,
  //                   ),
  //                   SizedBox(width: 8),
  //                   Text(
  //                     category['name'] as String,
  //                     style: TextStyle(
  //                       color: isSelected ? Colors.white : primaryBlue,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: 14,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildProductGrid() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: Obx(() {
        if (menuController.foodItems.isEmpty) {
          return SliverToBoxAdapter(
            child: _buildEmptyState(),
          );
        }

        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.48,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final product = menuController.foodItems[index];
              return _buildModernProductCard(product, index);
            },
            childCount: menuController.foodItems.length,
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: lightBlue.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.water_drop_outlined,
              size: 50,
              color: primaryBlue,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Belum Ada Produk",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Produk air mineral akan segera hadir",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernProductCard(FoodItem product, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.MENUDETAILCUSTOMER, arguments: product),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.1),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image with gradient overlay
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.asset(
                            product.image,
                            width: double.infinity,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Rating badge
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.amber, Colors.orange],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.star, color: Colors.white, size: 12),
                                SizedBox(width: 2),
                                Text(
                                  product.rating.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Water drop icon overlay
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.water_drop,
                              color: primaryBlue,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Product info
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product name
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
                            SizedBox(height: 8),

                            // Price with modern styling
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [lightBlue.withOpacity(0.3), lightBlue.withOpacity(0.1)],
                                ),
                                borderRadius: BorderRadius.circular(12),
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
                            SizedBox(height: 8),

                            // Description
                            Expanded(
                              child: Text(
                                product.Desc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                              ),
                            ),

                            // Bottom section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${product.soldCount} terjual',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      children: [
                                        ...List.generate(5, (starIndex) {
                                          return Icon(
                                            starIndex < product.rating.floor()
                                                ? Icons.star
                                                : Icons.star_border,
                                            color: Colors.amber,
                                            size: 12,
                                          );
                                        }),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [primaryBlue, darkBlue],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primaryBlue.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
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
                                    onPressed: () {
                                      cartController.addToCart(product);
                                      // Show snackbar
                                      Get.snackbar(
                                        "Berhasil!",
                                        "${product.name} ditambahkan ke keranjang",
                                        backgroundColor: primaryBlue.withOpacity(0.9),
                                        colorText: Colors.white,
                                        duration: Duration(seconds: 2),
                                        snackPosition: SnackPosition.BOTTOM,
                                        margin: EdgeInsets.all(16),
                                        borderRadius: 12,
                                        icon: Icon(Icons.check_circle, color: Colors.white),
                                      );
                                    },
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
          ),
        );
      },
    );
  }
}