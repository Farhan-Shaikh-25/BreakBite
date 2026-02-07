import 'package:flutter/material.dart';


class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration(),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          _BillRow("Subtotal", "₹360"),
          _BillRow("Taxes & Fees (5%)", "₹18"),
          Divider(color: Colors.grey),
          _BillRow(
            "Total Amount",
            "₹378",
            bold: true,
          ),
        ],
      ),
    );
  }
}

class _BillRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _BillRow(this.label, this.value, {this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              )),
          Text(value,
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              )),
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