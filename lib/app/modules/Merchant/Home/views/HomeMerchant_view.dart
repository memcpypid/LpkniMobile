import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Merchant/Model/Merchantfood_model.dart';
import 'package:lpkni/app/modules/Merchant/Home/controllers/HomeMerchant_controller.dart';
import 'package:lpkni/app/modules/Merchant/Menu/views/MenuMerchant_view.dart';

class HomemerchantView extends StatelessWidget {
  final HomemerchantController homeController =
      Get.find<HomemerchantController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(context),
              _buildSalesInfo(),
              _buildQuickActions(context), // Pass context here
              _buildMerchantInfo(),
              // _buildPromoBanner(),
              _buildSectionTitle("Menu Anda", 'Menu Anda Saat ini', () {}),
              _buildProductList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              const SizedBox(height: 2), // Beri jarak antara title dan subtitle
              Text(
                subtitle,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey), // Subtitle dengan warna abu-abu
              ),
            ],
          ),
          // GestureDetector(
          //   onTap: onTap,
          //   child: const Text("Semua >", style: TextStyle(color: Colors.teal)),
          // ),
        ],
      ),
    );
  }

  // 🔹 App Bar (Lokasi dan Notifikasi)
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.black, size: 18),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              "warung barokah - Sukun",
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.message, color: Colors.black),
            onPressed: () {
              Get.toNamed('/chat-list-merchant');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Get.toNamed('/notification-merchant');
            },
          ),
        ],
      ),
    );
  }

  // 🔹 Total Penjualan
  Widget _buildSalesInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF03A980),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            const Icon(Icons.account_balance_wallet_outlined,
                size: 40, color: Colors.white),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Total Penjualan hari ini",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text(
                  "Rp 50.000",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Quick Actions Menu
  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        children: [
          _buildQuickActionItem(
              Icons.shopping_bag_outlined, "Menu", context), // Pass context
          _buildQuickActionItem(Icons.shopping_cart_outlined, "Bahan", context),
          _buildQuickActionItem(Icons.campaign_outlined, "Promosi", context),
          _buildQuickActionItem(
              Icons.receipt_long_outlined, "Pesanan", context),
          _buildQuickActionItem(Icons.bar_chart_outlined, "Analisis", context),
          _buildQuickActionItem(
              Icons.storefront_outlined, "Toko Saya", context),
          _buildQuickActionItem(Icons.people_alt_outlined, "Karyawan", context),
          _buildQuickActionItem(
              Icons.request_page_outlined, "Pengajuan Pinjaman", context),
          _buildQuickActionItem(Icons.reviews_outlined, "Ulasan", context),
          _buildQuickActionItem(Icons.school_outlined, "Akademi", context),
          _buildQuickActionItem(
              Icons.event_note_outlined, "Reservasi", context),
        ],
      ),
    );
  }

  // 🔹 Quick Action Item
  Widget _buildQuickActionItem(
      IconData icon, String label, BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            switch (label) {
              case 'Menu':
                Get.toNamed('/menu-merchant');
                print(label);
                break;
              case 'Bahan':
                print(label);
                break;
              case 'Promosi':
                print(label);
                break;
              case 'Pesanan':
                print(label);
                break;
              case 'Analisis':
                print(label);
                break;
              case 'Toko Saya':
                print(label);
                break;
              case 'Karyawan':
                print(label);
                break;
              case 'Pengajuan Pinjaman':
                print(label);
                break;
              case 'Ulasan':
                print(label);
                break;
              case 'Akademi':
                print(label);
                break;
              case 'Reservasi':
                print(label);
                break;
              default:
                break;
            } // Simulasi tindakan saat ditekan
          },
          borderRadius: BorderRadius.circular(8), // Tambahkan efek ripple
          splashColor: Colors.teal.withOpacity(0.3), // Warna efek saat ditekan
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 30, color: Colors.black),
          ),
        ),
        const SizedBox(height: 5),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  // 🔹 Merchant Info
  Widget _buildMerchantInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Merchant serupa di Sukun memiliki 10.0x lebih banyak Penjualan dari Anda",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xFF03A980),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/images/merchant_banner.png", // Ganti dengan path gambar aset
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Promo Banner
  // Widget _buildPromoBanner() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Expanded(
  //           child: Text(
  //             "Diskon item adalah alat marketing populer yang digunakan",
  //             style: const TextStyle(
  //               fontSize: 12,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: const Color(0xFF03A980),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           ),
  //           onPressed: () {},
  //           child: const Text(
  //             "Pakai",
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 14,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // 🔹 Daftar Produk yang Ditampilkan di Home Merchant
  Widget _buildProductList() {
    return Obx(() {
      if (homeController.foodList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fastfood_outlined,
                  size: 80, color: Colors.grey[400]), // 🔹 Ikon lebih besar
              const SizedBox(height: 12), // 🔹 Jarak antar elemen
              Text(
                "Belum ada makanan yang Anda tambahkan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // 🔹 Navigasi ke halaman tambah makanan
                  Get.to(() => MenumerchantView());
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Tambahkan Makanan",
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }
      return GridView.builder(
        shrinkWrap: true, // ✅ Fix: Mengatasi error viewport
        physics:
            const NeverScrollableScrollPhysics(), // ✅ Fix: Menghindari konflik scroll
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.6,
        ),
        itemCount: homeController.foodList.length,
        itemBuilder: (context, index) {
          var food = homeController.foodList[index];
          return _buildFoodItem(food);
        },
      );
    });
  }

  // 🔹 Widget Produk di Home Merchant (Tanpa Tombol Edit & Delete)
  Widget _buildFoodItem(FoodItem food) {
    return GestureDetector(
      onTap: () {
        // TODO: Tambahkan navigasi ke detail menu jika diperlukan
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF03A980),
              Color(0xFF028A76)
            ], // ✅ Gradient lebih modern
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Gambar Produk dengan Border Melengkung
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                food.image,
                width: double.infinity,
                height: 120, // ✅ Perbesar gambar untuk lebih menonjol
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            // 🔹 Nama Produk
            Text(
              food.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16, // ✅ Perbesar font agar lebih readable
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),

            // 🔹 Deskripsi Produk
            Text(
              food.description,
              style: const TextStyle(
                color: Colors.white70, // ✅ Warna lebih soft
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // 🔹 Informasi Tambahan: Stok & Tag dalam Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stok : ${food.quantity}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54, // ✅ Background lebih kontras
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    food.tag,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 🔹 Harga & Icon Shopping Cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ✅ Harga dengan Badge Kuning
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'RP.${food.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // ✅ Detail
                InkWell(
                  onTap: () {
                    // TODO: Tambahkan ke Detail
                  },
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.white.withOpacity(0.3),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.details, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
