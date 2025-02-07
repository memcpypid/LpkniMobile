import 'package:get/get.dart';
import 'package:lpkni/app/modules/onBoarding/bindings/onBoarding_binding.dart';
import 'package:lpkni/app/modules/onBoarding/views/onBoarding_view.dart';
import 'package:lpkni/app/modules/pilih%20role/bindings/pilihrolebinding.dart';
import 'package:lpkni/app/modules/pilih%20role/views/pilihroleview.dart';
import 'package:lpkni/app/modules/sponsor/bindings/sponsorbinding.dart';
import 'package:lpkni/app/modules/sponsor/views/sponsorview.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PILIHKATEGORI,
      page: () => PilihRoleView(),
      binding: PilihRoleBinding(),
    ),
    GetPage(
      name: _Paths.SPONSOR,
      page: () => SponsorView(),
      binding: Sponsorbinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING2,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
