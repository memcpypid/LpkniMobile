import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/bindings/cartCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Cart/views/cartCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Chat/bindings/CustomerChat_binding.dart';
import 'package:lpkni/app/modules/Customer/Chat/views/CustomerChatList_view.dart';
import 'package:lpkni/app/modules/Customer/Chat/views/CustomerRoomChat_view.dart';
import 'package:lpkni/app/modules/Customer/Checkout/binding/Checkout_binding.dart';
import 'package:lpkni/app/modules/Customer/Checkout/view/checkout_view.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/bindings/ForgotCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/bindings/ResetPasswordCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/bindings/StatusPasswordCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/bindings/VerifotpCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/views/ForgotCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/views/ResetPasswordCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/views/StatusPasswordCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/ForgotPassword/views/VerifotpCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Home/bindings/HomeCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Home/views/HomeCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Landing/bindings/LandingCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Landing/views/LandingCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Login/bindings/loginCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Login/views/loginCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Products/bindings/Products_binding.dart';
import 'package:lpkni/app/modules/Customer/Products/views/Products_view.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/bindings/menuDetailCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/MenuDetail/views/MenuDetailCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/NewsDetail/bindings/NewsDetailCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/NewsDetail/views/NewsDetailCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Notification/bindings/notificationCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Notification/views/notificationCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Profile/bindings/CustomerProfile_binding.dart';
import 'package:lpkni/app/modules/Customer/Profile/views/CustomerProfile_view.dart';
import 'package:lpkni/app/modules/Customer/Profile/views/detailProfile_view.dart';
import 'package:lpkni/app/modules/Customer/Register/bindings/RegisterCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Register/views/RegisterCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/historyOrder/bindings/historyOrders_binding.dart';
import 'package:lpkni/app/modules/Customer/historyOrder/views/historyOrders_view.dart';
import 'package:lpkni/app/modules/onBoarding/bindings/onBoarding_binding.dart';
import 'package:lpkni/app/modules/onBoarding/views/onBoarding_view.dart';
import 'package:lpkni/app/modules/splashScreen/bindings/splashScreen_binding.dart';
import 'package:lpkni/app/modules/splashScreen/views/splashScreen_view.dart';
import 'package:lpkni/app/modules/splashScreen/bindings/splashScreen_binding.dart';
import 'package:lpkni/app/modules/splashScreen/views/splashScreen_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.ONBOARDING;
  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashScreen(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashScreen(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    /*------------------- Customer ---------------------------*/
    GetPage(
      name: _Paths.LANDINGCUSTOMER,
      page: () => LandingcustomerView(),
      binding: LandingcustomerBinding(),
    ),
    GetPage(
      name: _Paths.REGISTERCUSTOMER,
      page: () => RegistercustomerView(),
      binding: RegistercustomerBinding(),
    ),
    GetPage(
      name: _Paths.LOGINCUSTOMER,
      page: () => LogincustomerView(),
      binding: LogincustomerBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORDCUSTOMER,
      page: () => ForgotcustomerView(),
      binding: ForgotcustomerBinding(),
    ),
    GetPage(
      name: _Paths.OTPPASSWORDCUSTOMER,
      page: () => VerifotpcustomerView(),
      binding: VerifotpcustomerBinding(),
    ),
    GetPage(
      name: _Paths.RESETPASSWORDCUSTOMER,
      page: () => ResetpasswordcustomerView(),
      binding: ResetpasswordcustomerBinding(),
    ),
    GetPage(
      name: _Paths.STATUSRESETPASSWORDCUSTOMER,
      page: () => StatuspasswordcustomerView(),
      binding: StatuspasswordcustomerBinding(),
    ),
    GetPage(
      name: _Paths.HOMECUSTOMER,
      page: () => HomecustomerView(),
      binding: HomecustomerBinding(),
    ),
    GetPage(
      name: _Paths.MENUCUSTOMER,
      page: () => ProductsView(),
      binding: ProductsBinding(),
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
      name: _Paths.MENUDETAILCUSTOMER,
      page: () => MenudetailcustomerView(
        productItem: Get.arguments,
      ),
      binding: MenudetailcustomerBinding(),
    ),
    GetPage(
      name: _Paths.NEWSDETAILCUSTOMER,
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
    GetPage(
      name: _Paths.DETAILPROFILE,
      page: () => ProfileDetailView(),
      binding: DetailProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ORDERHISTORY,
      page: () => OrderHistoryView(),
      binding: HistoryordersBinding(),
    ),
  ];
}
