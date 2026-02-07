import 'package:flutter/material.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              "assets/images/sandwich.png",
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Chicken Grilled Sandwich",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Grilled chicken with special sauce",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(Icons.circle, color: Colors.red, size: 8),
                    SizedBox(width: 6),
                    Text("Non-Veg",
                        style:
                        TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "₹120",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(Icons.delete, color: Colors.red),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("-", style: TextStyle(fontSize: 18)),
                    ),
                    Text("3",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("+", style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Item Total: ₹360",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.grey.shade900,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: Colors.yellow),
  );
}