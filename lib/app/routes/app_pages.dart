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
import 'package:lpkni/app/modules/Merchant/Chat/bindings/MerchantChat_binding.dart';
import 'package:lpkni/app/modules/Merchant/Chat/views/MerchantChatList_view.dart';
import 'package:lpkni/app/modules/Merchant/Chat/views/MerchantRoomChat_view.dart';
import 'package:lpkni/app/modules/Merchant/Home/bindings/HomeMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Home/views/HomeMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Menu/bindings/MenuMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Menu/views/MenuMerchantEdit_view.dart';
import 'package:lpkni/app/modules/Merchant/Menu/views/MenuMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Notification/bindings/notificationMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Notification/views/notificationMerchant_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMEMERCHANT;

  static final routes = [
    /*------------------- Customer ---------------------------*/
    GetPage(
      name: _Paths.HOMECUSTOMER,
      page: () => HomecustomerView(),
      binding: HomecustomerBinding(),
    ),
    GetPage(
      name: _Paths.MENUCUSTOMER,
      page: () => CustomermenuView(),
      binding: CustomermenuBinding(),
    ),
    GetPage(
      name: _Paths.CARTCUSTOMER,
      page: () => CartcustomerView(),
      binding: CartcustomerBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONCUSTOMER,
      page: () => NotificationcustomerView(),
      binding: NotificationcustomerBinding(),
    ),
    GetPage(
      name: _Paths.CHATLISTCUSTOMER,
      page: () => CustomerchatlistView(),
      binding: CustomerchatBinding(),
    ),
    GetPage(
      name: _Paths.ROOMCHATCUSTOMER,
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
      name: _Paths.NEWSDETAIL,
      page: () => NewsdetailcustomerView(
        news: Get.arguments,
      ),
      binding: NewsdetailcustomerBinding(),
    ),
    GetPage(
      name: _Paths.PROFILECUSTOMER,
      page: () => CustomerprofileView(),
      binding: CustomerprofileBinding(),
    ),
    /*------------------- Merchant ---------------------------*/
    GetPage(
      name: _Paths.HOMEMERCHANT,
      page: () => HomemerchantView(),
      binding: HomemerchantBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONMERCHANT,
      page: () => NotificationmerchantView(),
      binding: NotificationmerchantBinding(),
    ),
    GetPage(
      name: _Paths.CHATLISTMERCHANT,
      page: () => MerchantchatlistView(),
      binding: MerchantchatBinding(),
    ),
    GetPage(
      name: _Paths.ROOMCHATMERCHANT,
      page: () => MerchantroomchatView(
        chatUser: Get.arguments,
      ),
      binding: MerchantchatBinding(),
    ),
    GetPage(
      name: _Paths.MENUMERCHANT,
      page: () => MenumerchantView(),
      binding: MenumerchantBinding(),
    ),
    GetPage(
      name: _Paths.EDITMENUMERCHANT,
      page: () => MenumerchanteditView(
        food: Get.arguments,
      ),
      binding: MenumerchantBinding(),
    ),
    GetPage(
      name: _Paths.ADDMENUMERCHANT,
      page: () => MenumerchanteditView(),
      binding: MenumerchantBinding(),
    ),
  ];
}
