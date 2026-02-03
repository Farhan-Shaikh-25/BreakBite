import 'package:flutter/material.dart';
import 'package:frontend/admin_utils/admin_order.dart';

class HistoryPage extends StatefulWidget{
  final List<AdminOrder> historyOrders;

  const HistoryPage({super.key, required this.historyOrders});

  @override
  State<HistoryPage> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage>{

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.historyOrders.length,
      itemBuilder: (context, index) {
        final order = widget.historyOrders[index];
        return Card(
          color: Colors.grey[900],
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: Text(order.uid, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("${order.uid} • ₹${order.totalAmount}", style: const TextStyle(color: Colors.white70)),
            trailing: Text(order.orderDate.toString(), style: const TextStyle(color: Colors.grey)),
          ),
        );
      },
    );
  }
}