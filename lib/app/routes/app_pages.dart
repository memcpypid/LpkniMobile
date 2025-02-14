import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Cart/bindings/cartCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Cart/views/cartCustomer_view.dart';
import 'package:lpkni/app/modules/Customer/Chat/bindings/CustomerChat_binding.dart';
import 'package:lpkni/app/modules/Customer/Chat/views/CustomerChatList_view.dart';
import 'package:lpkni/app/modules/Customer/Chat/views/CustomerRoomChat_view.dart';
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
import 'package:lpkni/app/modules/Customer/Register/bindings/RegisterCustomer_binding.dart';
import 'package:lpkni/app/modules/Customer/Register/views/RegisterCustomer_view.dart';
import 'package:lpkni/app/modules/Merchant/Chat/bindings/MerchantChat_binding.dart';
import 'package:lpkni/app/modules/Merchant/Chat/views/MerchantChatList_view.dart';
import 'package:lpkni/app/modules/Merchant/Chat/views/MerchantRoomChat_view.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/bindings/ForgotMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/bindings/StatusPasswordMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/bindings/VerifotpMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/views/ForgotMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/views/StatusPasswordMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/ForgotPassword/views/VerifotpMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Home/bindings/HomeMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Home/views/HomeMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Landing/bindings/LandingMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Landing/views/LandingMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Login/bindings/loginMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Login/views/loginMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Menu/bindings/MenuMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Menu/views/MenuMerchantEdit_view.dart';
import 'package:lpkni/app/modules/Merchant/Menu/views/MenuMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Notification/bindings/notificationMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Notification/views/notificationMerchant_view.dart';
import 'package:lpkni/app/modules/Merchant/Register/bindings/RegisterMerchant_binding.dart';
import 'package:lpkni/app/modules/Merchant/Register/views/RegisterMerchant_view.dart';
import 'package:lpkni/app/modules/onBoarding/bindings/onBoarding_binding.dart';
import 'package:lpkni/app/modules/onBoarding/views/onBoarding_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
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
      name: _Paths.MENUDETAILCUSTOMER,
      page: () => MenudetailcustomerView(
        foodItem: Get.arguments,
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
    /*------------------- Merchant ---------------------------*/
    GetPage(
      name: _Paths.LANDINGMERCHANT,
      page: () => LandingmerchantView(),
      binding: LandingmerchantBinding(),
    ),
    GetPage(
      name: _Paths.REGISTERMERCHANT,
      page: () => RegistermerchantView(),
      binding: RegistermerchantBinding(),
    ),
    GetPage(
      name: _Paths.LOGINMERCHANT,
      page: () => LoginmerchantView(),
      binding: LoginmerchantBinding(),
    ),
    GetPage(
      name: _Paths.FORGOTPASSWORDMERCHANT,
      page: () => ForgotmerchantView(),
      binding: ForgotmerchantBinding(),
    ),
    GetPage(
      name: _Paths.OTPPASSWORDMERCHANT,
      page: () => VerifotpmerchantView(),
      binding: VerifotpmerchantBinding(),
    ),
    GetPage(
      name: _Paths.RESETPASSWORDMERCHANT,
      page: () => ResetpasswordcustomerView(),
      binding: ResetpasswordcustomerBinding(),
    ),
    GetPage(
      name: _Paths.STATUSRESETPASSWORDMERCHANT,
      page: () => StatuspasswordmerchantView(),
      binding: StatuspasswordmerchantBinding(),
    ),
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
