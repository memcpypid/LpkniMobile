import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/cart_model.dart';
import 'package:lpkni/app/modules/Customer/CartCustomer/bindings/cartCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/CartCustomer/views/cartCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Home/bindings/HomeCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Home/views/HomeCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Menu/bindings/CustomerMenu_binding.dart';
import 'package:lpkni/app/modules/Customer/Menu/views/CustomerMenu_view.dart';
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
  ];
}
