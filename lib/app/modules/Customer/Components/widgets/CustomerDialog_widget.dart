import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSuccessDialog() {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Ikon centang
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(20),
              child: const Icon(
                Icons.check_circle,
                color: Colors.teal,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Teks "Berhasil!"
            const Text(
              "Berhasil!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // ✅ Deskripsi
            const Text(
              "Anda telah berhasil\nmenambahkan menu ke keranjang",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Tombol "Kembali"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Get.back(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Kembali",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
