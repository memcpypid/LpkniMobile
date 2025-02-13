import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/food_model.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/controllers/MenuDetailCustomer_controller.dart';

class MenudetailcustomerView extends StatelessWidget {
  final FoodItem foodItem;
  final MenudetailcustomerController controller =
      Get.put(MenudetailcustomerController());

  MenudetailcustomerView({required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ✅ Gambar Utama
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(foodItem.image, height: 300, fit: BoxFit.cover),
          ),

          // ✅ Tombol Kembali
          Positioned(
            top: 40,
            left: 15,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Get.back(),
            ),
          ),

          // ✅ Tombol Favorit
          Positioned(
            top: 40,
            right: 15,
            child: Obx(() {
              return IconButton(
                icon: Icon(
                  controller.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: controller.toggleFavorite,
              );
            }),
          ),

          // ✅ Konten Detail
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Nama Produk & Chat
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            foodItem.name,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chat, color: Colors.green),
                            onPressed: () {
                              // TODO: Navigasi ke Chat
                            },
                          ),
                        ],
                      ),
                      // ✅ Rating & Terjual
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 20),
                          Text(
                              "${foodItem.rating} (${foodItem.soldCount} reviews)",
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      // ✅ Harga
                      Row(
                        children: [
                          Text(
                            foodItem.price,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Rp18.000",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ✅ Deskripsi
                      const Text("Deskripsi",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(foodItem.Desc,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),

                      const SizedBox(height: 10),

                      // ✅ Spicy Level
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Spicy", style: TextStyle(fontSize: 16)),
                          Text("Jumlah", style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Obx(() {
                              return Slider(
                                value: controller.spicyLevel.value,
                                onChanged: controller.updateSpicyLevel,
                                min: 0,
                                max: 10,
                                activeColor: Colors.red,
                              );
                            }),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    color: Colors.green),
                                onPressed: controller.decreaseQuantity,
                              ),
                              Obx(() {
                                return Text(
                                    controller.quantity.value.toString(),
                                    style: const TextStyle(fontSize: 16));
                              }),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline,
                                    color: Colors.green),
                                onPressed: controller.increaseQuantity,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ✅ Tombol Checkout
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                            ),
                            onPressed: () {
                              // TODO: Tambah ke keranjang atau reservasi
                            },
                            child: const Text("Tambah Pesanan",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
