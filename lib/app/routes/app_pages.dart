import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Home/bindings/HomeCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Home/views/HomeCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Landing/bindings/LandingCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Landing/views/LandingCustomer_view.dart';

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
  ];
}
