import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // ganti dotenv
import 'package:lpkni/app/services/api_service.dart';
import 'package:lpkni/app/services/auth_service.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load .env
  await dotenv.load(fileName: ".env");

  // buat AuthService (sudah ada dio + cookie manager)
  final authService = await AuthService.create();

  // inject ke GetX
  Get.put<AuthService>(authService);
  Get.put<ApiService>(ApiService(authService));

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
