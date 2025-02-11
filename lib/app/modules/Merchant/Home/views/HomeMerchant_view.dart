import 'package:flutter/material.dart';
import 'package:lpkni/app/modules/Merchant/Menu/views/MenuMerchant_view.dart';

class HomemerchantView extends StatelessWidget {
  final List<Map<String, String>> foodList; // Accept foodList as a parameter

  const HomemerchantView({super.key, required this.foodList});

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
              _buildPromoBanner(),
              _buildProductList(),
            ],
          ),
        ),
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
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
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
              Icons.request_page_outlined, "Ajuan Utang", context),
          _buildQuickActionItem(Icons.reviews_outlined, "Ulasan", context),
          _buildQuickActionItem(Icons.school_outlined, "Academy", context),
          _buildQuickActionItem(
              Icons.event_note_outlined, "Reservation", context),
        ],
      ),
    );
  }

  // 🔹 Quick Action Item
  Widget _buildQuickActionItem(
      IconData icon, String label, BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (label == "Menu") {
              // Navigate to MenuMerchant screen when 'Menu' is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MenumerchantView(), // Navigate to MenuMerchant
                ),
              );
            }
          },
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
        Text(label, style: const TextStyle(fontSize: 12)),
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
  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Diskon item adalah alat marketing populer yang digunakan",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF03A980),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () {},
            child: const Text(
              "Pakai",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Daftar Produk yang Ditampilkan di Home Merchant
  Widget _buildProductList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: foodList.length, // Use the foodList passed from the menu
        itemBuilder: (context, index) {
          return _buildFoodItem(foodList[index]);
        },
      ),
    );
  }

  // 🔹 Widget Produk di Home Merchant (Tanpa Tombol Edit & Delete)
  Widget _buildFoodItem(Map<String, String> food) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF03A980),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              food['image']!,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            food['name']!,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            food['description']!,
            style: const TextStyle(color: Colors.white, fontSize: 10),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            "Stok: ${food['stock']}",
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 5),
          Text(
            "Tag: ${food['tag']}",
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
