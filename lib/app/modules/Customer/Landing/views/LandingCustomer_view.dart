import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/Landing/controllers/LandingCustomer_controller.dart';
import 'package:lpkni/app/routes/app_pages.dart';

class LandingcustomerView extends GetView<LandingcustomerController> {
  const LandingcustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Customer',
        //   style: TextStyle(
        //     fontSize: 25, 
        //     fontWeight: FontWeight.bold, 
        //     color: Colors.white,
        //   ),
        // ),
        centerTitle: true,
        backgroundColor: const Color(0xFF86AEFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.offAllNamed(Routes.ONBOARDING),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF86AEFF),
                Color(0xFF5B8DEF),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFF),
              Color(0xFFE8F2FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF86AEFF).withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF86AEFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(
                              'assets/images/qmas-logo.png',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Selamat Datang',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3748),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Silakan masuk atau daftar untuk melanjutkan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Login Button
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFF86AEFF),
                              Color(0xFF5B8DEF),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF86AEFF).withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.LOGINCUSTOMER);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.login,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Masuk',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Register Button
                      // Container(
                      //   width: double.infinity,
                      //   height: 56,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(16),
                      //     border: Border.all(
                      //       color: const Color(0xFF86AEFF),
                      //       width: 2,
                      //     ),
                      //     color: Colors.white,
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: const Color(0xFF86AEFF).withOpacity(0.1),
                      //         blurRadius: 8,
                      //         offset: const Offset(0, 2),
                      //       ),
                      //     ],
                      //   ),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       Get.toNamed(Routes.REGISTERCUSTOMER);
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Colors.white,
                      //       shadowColor: Colors.transparent,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(16),
                      //       ),
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         const Icon(
                      //           Icons.person_add,
                      //           color: Color(0xFF86AEFF),
                      //           size: 20,
                      //         ),
                      //         const SizedBox(width: 8),
                      //         const Text(
                      //           'Daftar',
                      //           style: TextStyle(
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.w600,
                      //             color: Color(0xFF86AEFF),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
