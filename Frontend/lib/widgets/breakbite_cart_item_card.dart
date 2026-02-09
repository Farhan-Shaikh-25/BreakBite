import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/order_provider.dart';// Ensure correct path to your provider

class CartItemCard extends StatelessWidget {
  final Item item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // We listen to the provider to handle the + and - logic
    final orderProvider = context.read<OrderProvider>();
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A), // Matches your card background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          // 1. Food Icon / Image Placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.yellow.withOpacity(0.5)),
            ),
            child: const Icon(Icons.fastfood, color: Colors.yellow, size: 30),
          ),

          const SizedBox(width: 16),

          // 2. Name and Price info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemName,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "₹${item.itemPrice * item.quantity}", // Total for this specific item
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 3. The Quantity Toggle (- 2 +)
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                _buildIconButton(
                  icon: Icons.remove,
                  onTap: () => orderProvider.decrementQuantity(item),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "${item.quantity}",
                    style: textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildIconButton(
                  icon: Icons.add,
                  onTap: () => orderProvider.addToCart(item, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to keep the main tree clean
  Widget _buildIconButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
    );
  }
}