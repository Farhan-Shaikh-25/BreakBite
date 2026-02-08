import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order.dart';
import 'package:frontend/admin_utils/admin_order_provider.dart';
import 'package:provider/provider.dart';
import 'admin_order_details.dart';

class AdminOrderCard extends StatelessWidget{
  final AdminOrder order;
  const AdminOrderCard({super.key, required this.order});
  
  @override
  Widget build(BuildContext context) {
    Color statusColor = Colors.grey;
    if (order.status == 'Processing') statusColor = Colors.orange;
    if (order.status == 'Preparing') statusColor = Colors.blue;
    if (order.status == 'Completed') statusColor = Colors.green;

    return GestureDetector(
      onTap: () {
        final provider = context.read<AdminOrderProvider>();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>
            ChangeNotifierProvider.value(
                value: provider,
                child: AdminOrderDetailsPage(order: order)
            )
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(15),
          border: Border(left: BorderSide(color: statusColor, width: 5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order #${order.id.substring(order.id.length - 4)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: Text(order.status.toUpperCase(), style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
              ],
            ),
            const Divider(color: Colors.white24),
            Text("${order.orderItems.length} Items • ₹${order.totalAmount}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}