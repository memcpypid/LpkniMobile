import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/bindings/cartCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Cart/views/cartCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Chat/bindings/CustomerChat_binding.dart';
import 'package:lpkni/app/modules/Customer/Chat/views/CustomerChatList_view.dart';
import 'package:lpkni/app/modules/Customer/Home/bindings/HomeCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Home/views/HomeCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Menu/bindings/CustomerMenu_binding.dart';
import 'package:lpkni/app/modules/Customer/Menu/views/CustomerMenu_view.dart';
import 'package:lpkni/app/modules/Customer/Notification/bindings/notificationCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Notification/views/notificationCustomer_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
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
    // GetPage(
    //   name: _Paths.ROOMCHAT,
    //   page: () => CustomerroomchatView(),
    //   binding: CustomerchatBinding(),
    // ),
  ];
}
