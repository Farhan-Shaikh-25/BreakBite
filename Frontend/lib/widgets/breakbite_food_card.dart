import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/order_provider.dart';
 // Ensure this points to your OrderProvider file

class BreakbiteFoodCard extends StatelessWidget {
  final Item item; // Pass the whole Item object for easier logic

  const BreakbiteFoodCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // We watch the provider so the card rebuilds when this specific item's quantity changes
    final orderProvider = context.watch<OrderProvider>();
    final int currentQty = orderProvider.getItemQuantity(item.itemId);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: Colors.yellow, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Title
            Text(
              item.itemName,
              style: const TextStyle(
                color: Colors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            // 🔹 Description (Using category as description for now)
            Text(
              item.category,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),

            // 🔹 Price + Logic-based Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹${item.itemPrice}",
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // --- TOGGLE LOGIC ---
                currentQty == 0
                    ? ElevatedButton(
                  onPressed: () => orderProvider.addToCart(item, context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text("+ Add"),
                )
                    : Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.remove, color: Colors.black, size: 20),
                        onPressed: () => orderProvider.decrementQuantity(item),
                      ),
                      Text(
                        "$currentQty",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(Icons.add, color: Colors.black, size: 20),
                        onPressed: () => orderProvider.addToCart(item, context),
                      ),
                    ],
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