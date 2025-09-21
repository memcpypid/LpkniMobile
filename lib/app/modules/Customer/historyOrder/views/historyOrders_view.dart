import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/modules/Customer/historyOrder/controllers/historyOrders_controller.dart';

class OrderHistoryView extends StatelessWidget {
  final OrderHistoryController controller = Get.find<OrderHistoryController>();
  final baseUrl = dotenv.env['BASE_URL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Riwayat Pesanan",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                _buildFilterChips(),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                );
              }
              if (controller.filteredOrders.isEmpty) {
                log("${controller.filteredOrders}");
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Belum ada riwayat pesanan",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Pesanan Anda akan muncul di sini",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await controller.loadOrderHistory();
                },
                color: Colors.blueAccent,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: controller.filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = controller.filteredOrders[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 16),
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.grey.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          childrenPadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.nomorFaktur,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Tanggal: ${order.createdAt ?? '-'}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(order.status),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _getStatusColor(order.status)
                                          .withOpacity(0.3),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  order.status ?? "Unknown",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getPaymentStatusColor(
                                    order.pembayaran?.status),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Pembayaran: ${order.pembayaran?.status ?? '-'}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          children: [
                            Container(
                              color: Colors.grey[50],
                              child: Column(
                                children: [
                                  const Divider(height: 1),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Detail Pesanan:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: order.orderItems.length,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(height: 8),
                                          itemBuilder: (context, i) {
                                            final item = order.orderItems[i];
                                            return Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.grey[200]!,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      item.produk.fotoProduk
                                                              .isNotEmpty
                                                          ? "${baseUrl}${item.produk.fotoProduk.first.url}"
                                                          : "",
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Container(
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightBlue
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: const Icon(
                                                            Icons.water_drop,
                                                            color: Colors.blue,
                                                            size: 24,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item.produk.nama,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          "${item.produk.kemasan} • Qty: ${item.jumlah}",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.blue[200]!,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.blue[700],
                                                size: 16,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  "Alamat: ${order.alamat?.detail ?? 'Alamat tidak tersedia'}",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.blue[800],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        // Button untuk menyelesaikan pesanan
                                        if (order.status == "DIKIRIM")
                                          Container(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: () =>
                                                  _showCompleteOrderDialog(
                                                      context, order),
                                              icon: const Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              label: const Text(
                                                "Selesaikan Pesanan",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF34C759),
                                                elevation: 2,
                                                shadowColor:
                                                    const Color(0xFF34C759)
                                                        .withOpacity(0.3),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 24,
                                                  vertical: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      'SEMUA',
      'PENDING',
      'DIPROSES',
      'DIKIRIM',
      'SELESAI',
      'DIBATALKAN'
    ];
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: filters.map((filter) {
            final isSelected = controller.selectedFilter.value == filter;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (_) => controller.filterOrders(filter),
                selectedColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.2),
                checkmarkColor: Colors.blueAccent,
                elevation: isSelected ? 2 : 0,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.blueAccent : Colors.black,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "DIPROSES":
        return const Color(0xFFFF9500); // Orange yang lebih modern
      case "DIKIRIM":
        return const Color(0xFF007AFF); // Blue yang lebih modern
      case "SELESAI":
        return const Color(0xFF34C759); // Green yang lebih modern
      case "DIBATALKAN":
        return const Color(0xFFFF3B30); // Red yang lebih modern
      default:
        return const Color(0xFF8E8E93); // Gray yang lebih modern
    }
  }

  Color _getPaymentStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "paid":
      case "lunas":
      case "berhasil":
        return const Color(0xFF34C759);
      case "pending":
      case "menunggu":
        return const Color(0xFFFF9500);
      case "failed":
      case "gagal":
        return const Color(0xFFFF3B30);
      default:
        return const Color(0xFF8E8E93);
    }
  }

  // Fungsi untuk menampilkan dialog konfirmasi
  void _showCompleteOrderDialog(BuildContext context, dynamic order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: const Color(0xFF34C759),
                size: 28,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Konfirmasi Penyelesaian",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Apakah Anda yakin ingin menyelesaikan pesanan ini?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nomor Faktur:",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.nomorFaktur,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Pesanan yang sudah diselesaikan tidak dapat diubah kembali.",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.orange[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Batal",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                _completeOrder(order);
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                "Ya, Selesaikan",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF34C759),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menyelesaikan pesanan
  void _completeOrder(dynamic order) {
    try {
      // Memanggil fungsi completeOrder dari controller
      controller.compliteOrder(order.id, "SELESAI");
      
      // Menampilkan snackbar konfirmasi
      Get.snackbar(
        "Berhasil",
        "Pesanan telah berhasil diselesaikan",
        backgroundColor: const Color(0xFF34C759),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        icon: const Icon(
          Icons.check_circle,
          color: Colors.white,
        ),
      );
    } catch (e) {
      // Menampilkan error jika terjadi kesalahan
      Get.snackbar(
        "Error",
        "Gagal menyelesaikan pesanan: ${e.toString()}",
        backgroundColor: const Color(0xFFFF3B30),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
        icon: const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      );
    }
  }
}
