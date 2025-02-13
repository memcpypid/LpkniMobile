import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/splashScreen/views/splashScreen_view.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      // home: SplashScreen(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
