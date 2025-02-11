import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/bindings/cartCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Cart/views/cartCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Chat/bindings/CustomerChat_binding.dart';
import 'package:lpkni/app/modules/Customer/Chat/views/CustomerChatList_view.dart';
import 'package:lpkni/app/modules/Customer/Chat/views/CustomerRoomChat_view.dart';
import 'package:lpkni/app/modules/Customer/Home/bindings/HomeCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Home/views/HomeCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Menu/bindings/CustomerMenu_binding.dart';
import 'package:lpkni/app/modules/Customer/Menu/views/CustomerMenu_view.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/bindings/menuDetailCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/views/MenuDetailCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/NewsDetail/bindings/NewsDetailCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/NewsDetail/views/NewsDetailCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Notification/bindings/notificationCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Notification/views/notificationCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Profile/bindings/CustomerProfile_binding.dart';
import 'package:lpkni/app/modules/Customer/Profile/views/CustomerProfile_view.dart';
import 'package:lpkni/app/modules/Merchant/Home/views/HomeMerchant_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMEMERCHANT;

  static final routes = [
    GetPage(
      name: _Paths.HOMEMERCHANT,
      page: () => HomemerchantView(
        foodList: [],
      ),
      binding: HomecustomerBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomecustomerView(),
      binding: HomecustomerBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => CustomermenuView(),
      binding: CustomermenuBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartcustomerView(),
      binding: CartcustomerBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationcustomerView(),
      binding: NotificationcustomerBinding(),
    ),
    GetPage(
      name: _Paths.CHATLIST,
      page: () => CustomerchatlistView(),
      binding: CustomerchatBinding(),
    ),
    GetPage(
      name: _Paths.ROOMCHAT,
      page: () => CustomerroomchatView(
        chatUser: Get.arguments,
      ),
      binding: CustomerchatBinding(),
    ),
    GetPage(
      name: _Paths.MENUDETAIL,
      page: () => MenudetailcustomerView(
        foodItem: Get.arguments,
      ),
      binding: MenudetailcustomerBinding(),
    ),
    GetPage(
      name: _Paths.MENUDETAIL,
      page: () => MenudetailcustomerView(
        foodItem: Get.arguments,
      ),
      binding: MenudetailcustomerBinding(),
    ),
    GetPage(
      name: _Paths.NEWSDETAIL,
      page: () => NewsdetailcustomerView(
        news: Get.arguments,
      ),
      binding: NewsdetailcustomerBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => CustomerprofileView(),
      binding: CustomerprofileBinding(),
    ),
  ];
}
