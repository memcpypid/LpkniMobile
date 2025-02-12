import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Merchant/Model/Merchantfood_model.dart';
import 'package:lpkni/app/modules/Merchant/Menu/controllers/MenuMerchant_controller.dart';
import 'package:lpkni/app/modules/Merchant/Menu/views/MenuMerchantEdit_view.dart';

class MenumerchantView extends StatelessWidget {
  final MenumerchantController foodController =
      Get.put(MenumerchantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ Latar belakang lembut
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() => foodController.foodList.isEmpty
                ? _buildEmptyState() // ✅ Tampilkan tampilan kosong jika tidak ada makanan
                : _buildFoodGrid()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Get.to(() => FoodFormView()),
      ),
    );
  }

  // ✅ App Bar dengan background lebih soft
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Menu Makanan Anda",
          style: TextStyle(color: Colors.black)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
    );
  }

  // ✅ Search Bar yang lebih elegan
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: (value) => foodController.searchQuery.value = value,
        decoration: InputDecoration(
          hintText: "Cari menu...",
          prefixIcon: const Icon(Icons.search, color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // ✅ GridView Produk dengan animasi lembut
  Widget _buildFoodGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio:
            0.52, // ✅ Menyesuaikan rasio agar tidak terlalu sempit
      ),
      itemCount: foodController.filteredFoodList.length,
      itemBuilder: (context, index) {
        var food = foodController.filteredFoodList[index];
        return _buildFoodCard(food);
      },
    );
  }

  // ✅ State kosong jika belum ada makanan
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.fastfood_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 10),
          const Text(
            "Belum ada makanan yang Anda tambahkan",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ✅ Card Produk yang lebih profesional
  Widget _buildFoodCard(FoodItem food) {
    return GestureDetector(
      // onTap: () => Get.to(() => FoodFormView(food: food)), // Buka form edit
      child: Card(
        color: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5, // ✅ Tambahkan bayangan lembut
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Gambar Produk dengan Hero Animation
              Hero(
                tag: food.id, // Unik untuk animasi transisi
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    food.image,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ✅ Nama Produk
              Text(
                food.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // ✅ Deskripsi dengan tampilan lebih elegan
              Text(
                food.description,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const Divider(
                height: 15,
                color: Colors.black,
                thickness: 1,
              ),
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
                      color: Colors.grey[200], // ✅ Background lebih kontras
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      food.tag,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // ✅ Harga dan tombol aksi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rp ${food.price}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      // ✅ Tombol Edit dengan efek hover
                      InkWell(
                        onTap: () => Get.to(() => FoodFormView(food: food)),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ]),
                          child: const Icon(Icons.edit,
                              size: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // ✅ Tombol Delete dengan animasi hover
                      InkWell(
                        onTap: () => foodController.deleteFood(food.id),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ]),
                          child: const Icon(Icons.delete,
                              size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
