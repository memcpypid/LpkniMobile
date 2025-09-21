import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
import 'package:lpkni/app/modules/Customer/Cart/controllers/cartCustomer_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/controllers/ButtomNavbar_controller.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/AddToCartBottomSheet_widget.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/BottomNavbar_widget.dart';
import 'package:lpkni/app/modules/Customer/Components/widgets/successDialog_widget.dart';
import 'package:lpkni/app/modules/Customer/Products/Controllers/Products_controller.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class ProductsView extends StatelessWidget {
  final ButtomnavbarController navbarController =
      Get.find<ButtomnavbarController>();
  final CartcustomerController cartController =
      Get.find<CartcustomerController>();
  final ProductsController controller = Get.find<ProductsController>();

  // final baseUrl = "https://dev.pollacheialnetworks.my.id";
  final baseUrl = dotenv.env['BASE_URL'];

  // Enhanced color palette
  final Color primaryBlue = Color(0xFF2196F3);
  final Color lightBlue = Color(0xFFE3F2FD);
  final Color darkBlue = Color(0xFF1976D2);
  final Color accentBlue = Color(0xFF0D47A1);
  final Color successGreen = Color(0xFF4CAF50);
  final Color warningOrange = Color(0xFFFF9800);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FBFF),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: primaryBlue,
        backgroundColor: Colors.white,
        child: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            _buildModernSliverAppBar(),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildSearchAndFilter(),
                ],
              ),
            ),
            _buildProductGrid(),
            _buildLoadingIndicator()
          ],
        ),
      ),
      bottomNavigationBar:
          BottomNavBar(controller: navbarController),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    controller.getProduk();
  }

  Widget _buildLoadingIndicator() {
  return Obx(() {
    if (controller.isLoading.value && controller.produkList.isNotEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: CircularProgressIndicator(color: primaryBlue),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  });
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
            colors: [primaryBlue, darkBlue],
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
                  "Q-MasM Store",
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
                colors: [primaryBlue, darkBlue],
              ),
            ),
            child: Stack(
              children: [
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
              gradient: LinearGradient(colors: [primaryBlue, darkBlue]),
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: Obx(() {
        if (controller.produkList.isEmpty) {
          return SliverToBoxAdapter(child: _buildEmptyState());
        }

        return SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio:
                0.46, // Adjusted aspect ratio for better card proportions
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final product = controller.produkList[index];
              return _buildEnhancedProductCard(product, index);
            },
            childCount: controller.produkList.length,
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
            child:
                Icon(Icons.water_drop_outlined, size: 50, color: primaryBlue),
          ),
          SizedBox(height: 20),
          Text(
            "Belum Ada Produk",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: darkBlue),
          ),
          SizedBox(height: 8),
          Text(
            "Produk air mineral akan segera hadir",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedProductCard(Produk product, int index) {
    final fotoProduk = product.fotoProduk.isNotEmpty
        ? "$baseUrl${product.fotoProduk.first.url}"
        : null;

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () =>
                  Get.toNamed(Routes.MENUDETAILCUSTOMER, arguments: product),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: primaryBlue.withOpacity(0.08),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced image section with better overlay
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                          child: Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  lightBlue.withOpacity(0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: fotoProduk != null
                                ? Image.network(
                                    fotoProduk,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: lightBlue.withOpacity(0.1),
                                        child: Icon(
                                          Icons.water_drop,
                                          size: 60,
                                          color: primaryBlue.withOpacity(0.3),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: lightBlue.withOpacity(0.1),
                                    child: Icon(
                                      Icons.water_drop,
                                      size: 60,
                                      color: primaryBlue.withOpacity(0.3),
                                    ),
                                  ),
                          ),
                        ),
                        // Stock status badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: product.stokAkhirBaik > 0
                                  ? successGreen.withOpacity(0.9)
                                  : warningOrange.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: (product.stokAkhirBaik > 0
                                          ? successGreen
                                          : warningOrange)
                                      .withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              product.stokAkhirBaik > 0 ? 'Tersedia' : 'Habis',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Sales badge
                        if (product.jmlPenjualan > 0)
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.amber, Colors.orange]),
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
                                  Icon(Icons.local_fire_department,
                                      color: Colors.white, size: 10),
                                  SizedBox(width: 2),
                                  Text(
                                    '${product.jmlPenjualan}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),

                    // Enhanced product info section
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product name with better typography
                            Text(
                              '${product.nama} - ${product.kemasan}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: darkBlue,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 8),

                            // Enhanced price display
                            // Container(
                            //   padding: EdgeInsets.symmetric(
                            //       horizontal: 12, vertical: 8),
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       colors: [
                            //         primaryBlue.withOpacity(0.1),
                            //         lightBlue.withOpacity(0.05),
                            //       ],
                            //     ),
                            //     borderRadius: BorderRadius.circular(16),
                            //     border: Border.all(
                            //       color: primaryBlue.withOpacity(0.2),
                            //       width: 1,
                            //     ),
                            //   ),
                            //   // child: Text(
                            //   //   "Rp ${_formatPrice(product.harga)}",
                            //   //   style: TextStyle(
                            //   //     color: accentBlue,
                            //   //     fontSize: 16,
                            //   //     fontWeight: FontWeight.bold,
                            //   //   ),
                            //   // ),
                            // ),
                            SizedBox(height: 10),

                            // Product details with icons
                            _buildProductDetail(Icons.location_on,
                                product.namaGudang ?? 'Tidak diketahui'),
                            SizedBox(height: 4),
                            _buildProductDetail(Icons.inventory,
                                'Stok: ${product.stokAkhirBaik}'),
                            SizedBox(height: 4),
                            _buildProductDetail(Icons.info_outline,
                                'Isi ${product.jumlahIsi} per ${product.satuan}'),

                            SizedBox(
                              height: 1,
                            ),

                            // Enhanced add to cart button
                            Container(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: product.stokAkhirBaik > 0
                                    ? () => _showAddToCartBottomSheet(product)
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: product.stokAkhirBaik > 0
                                        ? LinearGradient(
                                            colors: [primaryBlue, darkBlue])
                                        : LinearGradient(colors: [
                                            Colors.grey,
                                            Colors.grey.shade600
                                          ]),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: product.stokAkhirBaik > 0
                                        ? [
                                            BoxShadow(
                                              color:
                                                  primaryBlue.withOpacity(0.4),
                                              blurRadius: 12,
                                              offset: Offset(0, 6),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          product.stokAkhirBaik > 0
                                              ? 'Tambah ke Keranjang'
                                              : 'Stok Habis',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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

  Widget _buildProductDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[500], size: 14),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // String _formatPrice(int price) {
  //   return price.toString().replaceAllMapped(
  //         RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
  //         (Match m) => '${m[1]}.',
  //       );
  // }

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

    if (quantity != null && controller.isSuccess.value == true) {
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
