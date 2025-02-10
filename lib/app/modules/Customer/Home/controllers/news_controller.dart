import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';

class NewsController extends GetxController {
  var newsList = <News>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  void loadNews() {
    newsList.assignAll([
      News(
        title: "Kondisi Dapur Pak Muh Viral",
        description: "Berawal dari seorang pembeli yang mengaku...",
        image: "assets/news/news1.png",
        isPopular: true,
      ),
      News(
        title: "Kuliner Unik dari Berbagai Daerah",
        description: "Menjelajahi makanan khas dari berbagai daerah...",
        image: "assets/news/news1.png",
      ),
      News(
        title: "Resep Rahasia Nasi Goreng Spesial",
        description: "Pelajari bagaimana cara membuat nasi goreng terenak...",
        image: "assets/news/news1.png",
      ),
      News(
        title: "Resep Rahasia Nasi Goreng Spesial",
        description: "Pelajari bagaimana cara membuat nasi goreng terenak...",
        image: "assets/news/news1.png",
      ),
    ]);
  }
}
