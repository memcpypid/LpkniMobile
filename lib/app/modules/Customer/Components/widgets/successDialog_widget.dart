import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
import 'package:lpkni/app/modules/Customer/Products/Controllers/Products_controller.dart';

class SuccessDialog extends StatelessWidget {
  final Produk product;
  final int quantity;
  final Color primaryBlue;
  final Color successGreen;
  final Color darkBlue;

  const SuccessDialog({
    Key? key,
    required this.product,
    required this.quantity,
    required this.primaryBlue,
    required this.successGreen,
    required this.darkBlue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductsController>();

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [successGreen, Colors.green.shade600]),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: successGreen.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 40),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            Text(
              'Berhasil Ditambahkan!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              '${product.nama} (${quantity}x) telah ditambahkan ke keranjang Anda',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.back();
                      productController.isSuccess.value = false;
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: primaryBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text('Lanjut Belanja',
                        style: TextStyle(
                            color: primaryBlue, fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed("/cart-customer");
                      productController.isSuccess.value = false;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Lihat Keranjang',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
