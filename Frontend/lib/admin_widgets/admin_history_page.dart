import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order_provider.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget{
  const HistoryPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final historyOrders = context.watch<AdminOrderProvider>().historyOrders;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: historyOrders.length,
      itemBuilder: (context, index) {
        final order = historyOrders[index];
        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text("Order #${order.id.substring(order.id.length - 4)}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("${order.uid} • ₹${order.totalAmount}", style: const TextStyle(color: Colors.white70)),
            trailing: Text(order.orderDate.toString(), style: const TextStyle(color: Colors.grey)),
          ),
        );
      },
    );
  }
}