import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/order_provider.dart';

class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final total = orderProvider.getTotal();
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // Using a Card-like background to separate it from the scaffold black
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          // Row 1: Item Total
          _buildRow(context, "Item Total", "₹$total"),

          // Row 2: Canteen Charges (Hardcoded for now)
          _buildRow(context, "Canteen Charges", "₹0"),

          const Divider(color: Colors.white24, height: 24),

          // Row 3: Grand Total (Uses bigger font)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Grand Total",
                style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "₹$total",
                // Using yellow only for the final price to make it pop
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodyMedium?.copyWith(color: Colors.white70)),
          Text(value, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}