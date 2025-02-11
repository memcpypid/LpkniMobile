import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lpkni/app/modules/Merchant/Home/views/HomeMerchant_view.dart';

class MenumerchantView extends StatefulWidget {
  const MenumerchantView({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenumerchantView> {
  // Define foodList here
  List<Map<String, String>> foodList = [
    {
      'name': 'Rendang Jengkol',
      'price': 'Rp17.000',
      'description':
          'Rendang jengkol adalah varian rendang yang menggunakan jengkol sebagai bahan utama pengganti daging.',
      'image': 'assets/food/food1.png',
      'stock': '10',
      'tag': 'Makanan',
    },
    // Add more products here
  ];

  void _goToHomeMerchant() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomemerchantView(foodList: foodList), // Passing foodList
      ),
    );
  }

  void _showFoodForm({Map<String, String>? food, int? index}) async {
    TextEditingController nameController =
        TextEditingController(text: food?['name'] ?? '');
    TextEditingController priceController =
        TextEditingController(text: food?['price'] ?? '');
    TextEditingController descriptionController =
        TextEditingController(text: food?['description'] ?? '');
    TextEditingController stockController =
        TextEditingController(text: food?['stock'] ?? '0');
    TextEditingController tagController =
        TextEditingController(text: food?['tag'] ?? 'Makanan');
    String imagePath = food?['image'] ?? 'assets/images/rendang_jengkol.png';

    final ImagePicker _picker = ImagePicker();

    // Function to pick an image
    Future<void> _pickImage() async {
      // Open image picker to choose an image from gallery
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imagePath =
              pickedFile.path; // Update the image path to the selected image
        });
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food == null ? "Tambah Etalase" : "Edit Etalase",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                // Nama
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),

                // Stok
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(
                    labelText: "Stok",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),

                // Tag
                TextField(
                  controller: tagController,
                  decoration: const InputDecoration(
                    labelText: "Tag",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),

                // Harga
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: "Harga",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),

                // Deskripsi
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),

                // Gambar
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        imagePath, // Show the image path or selected image name
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF03A980),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                      ),
                      onPressed:
                          _pickImage, // Call the function to pick an image
                      child:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tombol Cancel dan Add/Edit
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tombol CANCEL
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("CANCEL",
                          style: TextStyle(color: Colors.white)),
                    ),
                    // Tombol ADD/EDIT
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        setState(() {
                          if (food == null) {
                            foodList.add({
                              'name': nameController.text,
                              'price': priceController.text,
                              'description': descriptionController.text,
                              'image': imagePath,
                              'stock': stockController.text,
                              'tag': tagController.text
                            });
                          } else {
                            foodList[index!] = {
                              'name': nameController.text,
                              'price': priceController.text,
                              'description': descriptionController.text,
                              'image': imagePath,
                              'stock': stockController.text,
                              'tag': tagController.text
                            };
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: Text(food == null ? "ADD" : "EDIT",
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteFood(int index) {
    setState(() {
      foodList.removeAt(index);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // This will pop the current screen and return to the previous one.
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black),
            onPressed:
                _goToHomeMerchant, // Tombol untuk berpindah ke HomeMerchant
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Pencarian & Filter
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.filter_list),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Tombol Tambah Makanan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF03A980),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () => _showFoodForm(), // Tambah makanan
                  child: const Icon(Icons.add, color: Colors.white),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                      onPressed: _goToHomeMerchant,
                      child: const Text(
                        "Lihat Home Merchant",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 List Makanan dalam GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  return _buildFoodItem(foodList[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(Map<String, String> food, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF03A980),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stack for image and price
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  food['image']!,
                  width: double.infinity,
                  height: 70, // Increased image height
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(
                        0.7), // Semi-transparent background for price
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Text(
                    food['price']!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Space between image and title

          // Title Section
          Text(
            food['name']!,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),

          // Description Section
          Container(
            height: 30,
            child: Text(
              food['description']!,
              style: const TextStyle(color: Colors.white, fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),

          // Stock Section
          Text(
            "Stok: ${food['stock']}",
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 4),

          // Tag Section
          Text(
            "Tag: ${food['tag']}",
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 8),

          // Edit and Delete buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: () => _showFoodForm(food: food, index: index),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.white),
                onPressed: () => _deleteFood(index),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
