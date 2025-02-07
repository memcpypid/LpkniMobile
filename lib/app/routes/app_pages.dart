import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/bindings/VerifotpCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/views/VerifotpCustomer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const VerifotpcustomerView(),
      binding: VerifotpcustomerBinding(),
    ),
  ];
}
