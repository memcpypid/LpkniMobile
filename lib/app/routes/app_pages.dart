import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/bindings/ResetPasswordCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/bindings/StatusPasswordCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/views/StatusPasswordCustomer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const StatuspasswordcustomerView(),
      binding: StatuspasswordcustomerBinding(),
    ),
  ];
}
