import 'package:get/get.dart';
import 'package:lpkni/app/modules/onBoarding/bindings/onBoarding_binding.dart';
import 'package:lpkni/app/modules/onBoarding/views/onBoardingLaki_view.dart';
import 'package:lpkni/app/modules/onBoarding/views/onBoardingPerempuan_view%20.dart';

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
      name: _Paths.ONBOARDING1,
      page: () => const OnboardingperempuanView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING2,
      page: () => const OnboardinglakiView(),
      binding: OnboardingBinding(),
    ),
  ];
}
