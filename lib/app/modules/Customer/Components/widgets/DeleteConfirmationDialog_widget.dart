import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String productName;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    Key? key,
    required this.productName,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 50),
            const SizedBox(height: 12),
            Text(
              "Hapus Produk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Apakah Anda yakin ingin menghapus $productName dari keranjang?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Batal"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  onPressed: () {
                    onConfirm();
                    Get.back();
                  },
                  child: Text("Hapus"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
