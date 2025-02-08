import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';

class CartcustomerView extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();

  CartcustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() {
        return cartController.cartItems.isEmpty
            ? const Center(child: Text("Keranjang masih kosong."))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Expanded(child: _buildCartItems()),
                    _buildPromoInput(),
                    _buildSummary(),
                    _buildCheckoutButton(),
                  ],
                ),
              );
      }),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: const Text("Keranjang", style: TextStyle(color: Colors.black)),
      centerTitle: true,
    );
  }

  Widget _buildCartItems() {
    return ListView.builder(
      itemCount: cartController.cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartController.cartItems[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(cartItem.product.image,
                      width: 70, height: 70, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(cartItem.product.price,
                          style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
                _buildQuantityControl(cartItem),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      cartController.removeFromCart(cartItem.product),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityControl(cartItem) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.teal),
          onPressed: () => cartController.decreaseQuantity(cartItem.product),
        ),
        Text(cartItem.quantity.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.teal),
          onPressed: () => cartController.increaseQuantity(cartItem.product),
        ),
      ],
    );
  }

  Widget _buildPromoInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.local_offer, color: Colors.teal),
          hintText: "Masukkan kode promo Anda",
          filled: true,
          fillColor: Colors.teal.withOpacity(0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          _buildSummaryItem("Subtotal", cartController.subtotal),
          _buildSummaryItem("Delivery Fee", cartController.deliveryFee),
          _buildSummaryItem("Coupon Discount", cartController.discount),
          const Divider(),
          _buildSummaryItem("Total Amount", cartController.totalPrice,
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text("Rp${value.toStringAsFixed(3)}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          minimumSize: const Size(double.infinity, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text("Checkout",
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: 2, // Index untuk tab keranjang
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.grey,
    );
  }
}
