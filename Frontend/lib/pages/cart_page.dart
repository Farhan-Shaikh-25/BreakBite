import 'package:flutter/material.dart';
import 'package:frontend/widgets/cart_item_card.dart';
import 'package:frontend/widgets/bill_details_card.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Cart"),
            SizedBox(height: 2),
            Text(
              "1 item",
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // 🔹 Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  CartItemCard(),
                  SizedBox(height: 20),
                  BillDetailsCard(),
                  // SizedBox(height: 20),
                  // PaymentNote(),
                  SizedBox(height: 100), // space before bottom buttons
                ],
              ),
            ),
          ),

          // 🔹 Fixed bottom actions
          // CartBottomActions(),
        ],
      ),
    );
  }
}