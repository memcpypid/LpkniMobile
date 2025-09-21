import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/NewsDetail/controllers/news_controller.dart';

class NewsdetailcustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
  }
}
