import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/pilih%20role/controllers/pilihrolecontroller.dart';

class PilihRoleView extends StatelessWidget {
  final PilihRoleController controller = Get.put(PilihRoleController());

  final List<Map<String, String>> categories = [
    {
      'title': 'Konsumen',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image': 'assets/images/swikonsumen.png'
    },
    {
      'title': 'Pemilik Warung',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image': 'assets/images/swimerchant.png'
    },
    {
      'title': 'Grosir',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image': 'assets/images/swigrosir.png'
    },
    {
      'title': 'Sponsor',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'image': 'assets/images/swisponsor.png'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.toNamed("/onboard2"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Anda mau masuk sebagai apa?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  var category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      controller.navigateToPage(category['title']!);
                      // controller.selectedCategory.value = category['title']!;
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              category['image']!,
                              width: double.infinity,
                              height: 170,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  category['title']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  category['description']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
