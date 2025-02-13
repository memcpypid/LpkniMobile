import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lpkni/app/data/Merchant/Model/Merchantfood_model.dart';
import 'package:lpkni/app/modules/Merchant/Menu/controllers/MenuMerchant_controller.dart';
import 'package:uuid/uuid.dart';

class MenumerchanteditView extends StatelessWidget {
  final MenumerchantController foodController = Get.find();
  final FoodItem? food;
  final _formKey = GlobalKey<FormState>();

  MenumerchanteditView({super.key, this.food});

  @override
  Widget build(BuildContext context) {
    // 🔹 Controllers untuk input fields
    TextEditingController nameController =
        TextEditingController(text: food?.name ?? "");
    TextEditingController priceController =
        TextEditingController(text: food?.price.toString() ?? "0");

    TextEditingController descriptionController =
        TextEditingController(text: food?.description ?? "");
    TextEditingController stockController =
        TextEditingController(text: food?.quantity.toString() ?? "0");
    TextEditingController tagController =
        TextEditingController(text: food?.tag ?? "");

    Rx<File?> imageFile = Rx<File?>(null);
    RxString imagePath = RxString(food?.image ??
        ""); // 🔥 Gunakan RxString untuk menyimpan path gambar yang ada

    return Scaffold(
      appBar: AppBar(
        title: Text(food == null ? "Tambah Makanan" : "Edit Makanan"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Preview Gambar
                Obx(() {
                  return GestureDetector(
                    onTap: () => _pickImage(imageFile, imagePath),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: imageFile.value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(imageFile.value!,
                                  fit: BoxFit.cover),
                            )
                          : imagePath.value.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(imagePath.value,
                                      fit: BoxFit.cover),
                                )
                              : const Center(
                                  child: Icon(Icons.camera_alt,
                                      size: 40, color: Colors.grey),
                                ),
                    ),
                  );
                }),
                const SizedBox(height: 16),

                // 🔹 Nama Makanan
                _buildTextField(nameController, "Nama Makanan", Icons.fastfood),

                // 🔹 Harga
                _buildTextField(priceController, "Harga", Icons.attach_money,
                    isNumber: true),

                // 🔹 Stok & Tag dalam satu baris
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                          stockController, "Stok", Icons.inventory,
                          isNumber: true),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(tagController, "Tag", Icons.label),
                    ),
                  ],
                ),

                // 🔹 Deskripsi
                _buildTextField(
                    descriptionController, "Deskripsi", Icons.description,
                    maxLines: 4),

                const SizedBox(height: 20),

                // 🔹 Tombol Simpan
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveFood(
                          nameController.text.trim(),
                          int.tryParse(priceController.text) ?? 0,
                          descriptionController.text.trim(),
                          stockController.text.trim(),
                          tagController.text.trim(),
                          imageFile.value != null
                              ? imageFile.value!.path
                              : imagePath
                                  .value); // 🔥 Gunakan gambar baru jika ada, jika tidak pakai gambar lama
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Center(
                    child: Text("SIMPAN",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Widget Custom TextField
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Field ini tidak boleh kosong!";
          }
          return null;
        },
      ),
    );
  }

  // 🔹 Simpan Data Makanan
  void _saveFood(String name, int price, String description, String stock,
      String tag, String imagePath) {
    final newFood = FoodItem(
      id: food?.id ?? const Uuid().v4(),
      name: name,
      price: price,
      description: description,
      image: 'assets/food/food1.png', // 🔥 Simpan path gambar (baru atau lama)
      tag: tag,
      quantity: int.tryParse(stock) ?? 0,
    );

    if (food == null) {
      foodController.addFood(newFood);
    } else {
      foodController.updateFood(
        food!.id,
        name: name,
        price: price,
        description: description,
        image:
            imagePath, // 🔥 Simpan gambar baru jika ada, jika tidak pakai gambar lama
        tag: tag,
        quantity: int.tryParse(stock) ?? food!.quantity,
      );
    }

    Get.back();
  }

  // 🔹 Pilih Gambar dari Galeri atau Kamera
  Future<void> _pickImage(Rx<File?> imageFile, RxString imagePath) async {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.teal),
            title: const Text("Ambil Foto"),
            onTap: () async {
              final XFile? pickedFile =
                  await picker.pickImage(source: ImageSource.camera);
              if (pickedFile != null) {
                imageFile.value = File(pickedFile.path);
                imagePath.value = ""; // Reset path lama jika ada gambar baru
              }
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.image, color: Colors.teal),
            title: const Text("Pilih dari Galeri"),
            onTap: () async {
              final XFile? pickedFile =
                  await picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                imageFile.value = File(pickedFile.path);
                imagePath.value = ""; // Reset path lama jika ada gambar baru
              }
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
