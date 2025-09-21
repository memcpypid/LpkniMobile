import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/news_model.dart';

class NewsController extends GetxController {
  // var newsList = <News>[].obs;
  // var selectedNews = Rxn<News>(); // ✅ Berita yang sedang ditampilkan

  @override
  void onInit() {
    super.onInit();
    // loadNews();
  }

  // void loadNews() {
  //   newsList.assignAll([
  //     News(
  //       title: "Kondisi dapur pak muh",
  //       description:
  //           "Dapur adalah tempat yang penting dalam sebuah rumah. Kebersihan dapur sangat mempengaruhi kesehatan penghuninya...",
  //       image: "assets/news/news1.png",
  //       author: "Admin Berita",
  //       date: "10 Februari 2024",
  //       time: "08:30",
  //       isPopular: true,
  //     ),
  //     News(
  //       title: "Tips Memasak Sehat",
  //       description:
  //           "Memasak sehat adalah kebiasaan yang baik untuk menjaga kesehatan keluarga...",
  //       image: "assets/news/news1.png",
  //       author: "Chef Dapur Sehat",
  //       date: "9 Februari 2024",
  //       time: "10:00",
  //     ),
  //   ]);
  // }

  // void selectNews(News news) {
  //   selectedNews.value = news;
  // }
}
