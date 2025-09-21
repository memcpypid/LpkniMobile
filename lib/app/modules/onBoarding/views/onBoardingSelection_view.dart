import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/onBoarding/controllers/onBoarding_controller.dart';

class OnboardingselectionView extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Selamat Datang",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Get.toNamed("/onboard2"),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kami Memberikan Solusi Untuk Anda",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  var category = controller.categories[index];
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
