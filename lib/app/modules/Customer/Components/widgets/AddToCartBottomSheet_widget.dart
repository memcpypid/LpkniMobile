import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpkni/app/data/Customer/Model/product_model.dart';
import 'package:lpkni/app/modules/Customer/Products/Controllers/Products_controller.dart';

class AddToCartBottomSheet extends StatefulWidget {
  final Produk product;
  final String baseUrl;
  final Color primaryBlue;
  final Color darkBlue;
  final Color lightBlue;

  const AddToCartBottomSheet({
    Key? key,
    required this.product,
    required this.baseUrl,
    required this.primaryBlue,
    required this.darkBlue,
    required this.lightBlue,
  }) : super(key: key);

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int quantity = 1;
  // final productController = Get.find<ProductsController>();
  final productController = Get.put(ProductsController());

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 20),

            // product info
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: widget.lightBlue.withOpacity(0.1),
                    child: widget.product.fotoProduk.isNotEmpty
                        ? Image.network(
                            "${widget.baseUrl}${widget.product.fotoProduk.first.url}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.water_drop,
                                  color: widget.primaryBlue);
                            },
                          )
                        : Icon(Icons.water_drop, color: widget.primaryBlue),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.product.nama} - ${widget.product.kemasan}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: widget.darkBlue,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Rp ${_formatPrice(widget.product.harga)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: widget.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // quantity selector
            Text(
              'Jumlah',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.darkBlue,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.primaryBlue.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: quantity > 1
                            ? () {
                                setState(() => quantity--);
                              }
                            : null,
                        icon: Icon(Icons.remove,
                            color: quantity > 1
                                ? widget.primaryBlue
                                : Colors.grey),
                      ),
                      Container(
                        width: 60,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.darkBlue,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: quantity < widget.product.stokAkhirBaik
                            ? () {
                                setState(() => quantity++);
                              }
                            : null,
                        icon: Icon(Icons.add,
                            color: quantity < widget.product.stokAkhirBaik
                                ? widget.primaryBlue
                                : Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Stok tersedia: ${widget.product.stokAkhirBaik}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 24),

            // total
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.lightBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: widget.primaryBlue.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: widget.darkBlue,
                      )),
                  Text(
                    'Rp ${_formatPrice(widget.product.harga * quantity)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // button
            Container(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  await productController.addCart(
                      widget.product.id, widget.product.gudangId, quantity);

                  if (productController.isSuccess.value == true) {
                    Get.back(result: quantity);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [widget.primaryBlue, widget.darkBlue]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.white, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Tambah ke Keranjang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
