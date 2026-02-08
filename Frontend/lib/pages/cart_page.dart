import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/order_provider.dart';
import '../widgets/breakbite_bill_details_card.dart';
import '../widgets/breakbite_cart_item_card.dart';

// import '../widgets/breakbite_bill_details_card.dart'; // I included the updated code for this below

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final cartItems = orderProvider.orderItems;
    final textTheme = Theme.of(context).textTheme; // Access your Poppins theme

    return Scaffold(
      // No backgroundColor needed; strictly uses main.dart's scaffoldBackgroundColor
      appBar: AppBar(
        // No backgroundColor needed; strictly uses main.dart's appBarTheme
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Checkout",
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            if (cartItems.isNotEmpty)
              Text(
                "${cartItems.length} items in tray",
                // Use labelSmall or bodySmall for subtitles
                style: textTheme.bodySmall?.copyWith(color: Colors.white70),
              ),
          ],
        ),
      ),
      body: cartItems.isEmpty
          ? _buildEmptyState(context)
          : Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Dynamic List
                  ...cartItems.map((item) => CartItemCard(item: item)).toList(),

                  const SizedBox(height: 24),

                  // We pass the provider data to the bill card
                  const BillDetailsCard(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _buildPlaceOrderButton(context, orderProvider),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_basket_outlined, size: 80, color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            "Your tray is empty!",
            // Uses your defined Poppins white style
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Go back to Menu",
              // We use bodyLarge but override color for the clickable action
              style: textTheme.bodyLarge?.copyWith(color: Colors.yellow),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton(BuildContext context, OrderProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A), // Slightly lighter black for contrast
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () async {
            await provider.placeOrder();
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order sent to kitchen!")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow, // Brand color
            foregroundColor: Colors.black,  // Text on yellow must be black
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            "Confirm Order",
            // We use titleMedium for button text, but force black for contrast against yellow
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}